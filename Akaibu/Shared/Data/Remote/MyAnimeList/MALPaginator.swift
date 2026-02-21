//
//  MALPaginator.swift
//  Akaibu
//
//  Created by kite1412 on 01/01/26.
//

import Foundation
import OSLog

class MALPaginator {
    static let shared = MALPaginator()
    private let client = MALHTTPClient.shared
    
    private init() {}
    
    func getPaginated<Item: Decodable & MALPagable>(
        path: String,
        headers: [String: String]? = nil,
        params: [String: String]? = nil
    ) async throws -> PaginatedResult<Item> {
        let req = client.createAuthenticatedRequest(
            path: path,
            httpMethod: "GET",
            headers: headers,
            params: params
        )
        let res: Item = try await client.perform(req)
        var next: NextResultClosure<Item> = nil
        
        if let nextURL = res.paging.next {
            next = { [weak self] in
                guard let self else { return nil }
                
                return try await self.getNext(url: nextURL)
            }
        }
        
        debugOnly {
            AppLogger.network.log("Next page for \(req.url?.absoluteString ?? "nil"): \(next != nil ? "present" : "not present")")
        }
        
        return PaginatedResult(data: res, next: next)
    }
    
    private func getNext<Item: Decodable & MALPagable>(url: String) async throws -> PaginatedResult<Item>? {
        guard let nextURL = URL(string: url) else { return nil }
        
        var req = URLRequest(url: nextURL)
        req.httpMethod = "GET"
        req.attachBearerToken()
        
        let res: Item = try await client.perform(req)
        var next: NextResultClosure<Item> = nil
        
        if let nextURL = res.paging.next {
            next = { [weak self] in
                guard let self else { return nil }
                
                return try await self.getNext(url: nextURL)
            }
        }
        
        return PaginatedResult(data: res, next: next)
    }
}
