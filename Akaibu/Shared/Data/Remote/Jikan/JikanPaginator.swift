//
//  JikanPaginator.swift
//  Akaibu
//
//  Created by kite1412 on 21/02/26.
//

import OSLog

class JikanPaginator {
    static let shared = JikanPaginator()
    private let client: JikanHTTPClient = .shared
    
    private init() {}
    
    func getPaginated<Item: Decodable & JikanPagable>(
        path: String,
        headers: [String: String]? = nil,
        params: [String: String]? = nil
    ) async throws -> PaginatedResult<Item> {
        let req = client.createRequest(
            path: path,
            httpMethod: "GET",
            headers: headers,
            params: params
        )
        let res: Item = try await client.perform(req)
        var next: NextResultClosure<Item> = nil
        
        if res.pagination.hasNextPage {
            next = { [weak self] in
                guard let self else { return nil }
                
                return try await self.getNext(
                    path: path,
                    pagination: res.pagination,
                    headers: headers,
                    params: params
                )
            }
        }
        
        debugOnly {
            AppLogger.network.log("Next page for \(req.url?.absoluteString ?? "nil"): \(next != nil ? "present" : "not present")")
        }
        
        return PaginatedResult(data: res, next: next)
    }
    
    private func getNext<Item: Decodable & JikanPagable>(
        path: String,
        pagination: JikanPagination,
        headers: [String: String]? = nil,
        params: [String: String]? = nil
    ) async throws -> PaginatedResult<Item>? {
        let req = getNextRequest(path: path, pagination: pagination, headers: headers, params: params)
        let res: Item = try await client.perform(req)
        var next: NextResultClosure<Item> = nil
        
        if res.pagination.hasNextPage {
            next = { [weak self] in
                guard let self else { return nil }
                
                return try await self.getNext(
                    path: path,
                    pagination: pagination,
                    headers: headers,
                    params: params,
                )
            }
        }
        
        return PaginatedResult(data: res, next: next)
    }
    
    private func getNextRequest(
        path: String,
        pagination: JikanPagination,
        headers: [String: String]? = nil,
        params: [String: String]? = nil
    ) -> URLRequest {
        var params = params ?? [:]
        params["page"] = "\(pagination.currentPage + 1)"
        
        return client.createRequest(
            path: path,
            httpMethod: "GET",
            headers: headers,
            params: params
        )
    }
}
