//
//  HTTPClient.swift
//  Akaibu
//
//  Created by kite1412 on 27/12/25.
//

import Foundation

class HTTPClient {
    let baseUrl: URL
    private let session: URLSession
    
    init(baseUrl: URL, session: URLSession = .shared) {
        self.baseUrl = baseUrl
        self.session = session
    }
    
    func get<T: Decodable>(_ path: String, headers: [String: String]? = nil) async throws -> T {
        try await perform(
            createRequest(
                path: path,
                httpMethod: "GET",
                headers: headers
            )
        )
    }
    
    func post<T: Decodable, Body: Encodable>(
        _ path: String,
        body: Body,
        headers: [String: String]? = nil
    ) async throws -> T {
        try await sendWithBody(
            path: path,
            httpMethod: "POST",
            body: body,
            headers: headers
        )
    }
    
    func put<T: Decodable, Body: Encodable>(
        _ path: String,
        body: Body,
        headers: [String: String]? = nil
    ) async throws -> T {
        try await sendWithBody(
            path: path,
            httpMethod: "PUT",
            body: body,
            headers: headers
        )
    }
    
    func delete<T: Decodable>(_ path: String, headers: [String: String]? = nil) async throws -> T {
        try await perform(
            createRequest(
                path: path,
                httpMethod: "DELETE",
                headers: headers
            )
        )
    }
    
    private func sendWithBody<T: Decodable, Body: Encodable>(
        path: String,
        httpMethod: String,
        body: Body,
        headers: [String: String]? = nil
    ) async throws -> T {
        var req = createRequest(
            path: path,
            httpMethod: httpMethod,
            headers: headers
        )
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.httpBody = try JSONEncoder().encode(body)
        
        return try await perform(req)
    }
    
    private func perform<T: Decodable>(_ request: URLRequest) async throws -> T {
        let (data, response) = try await session.data(for: request)
        guard let httpResp = response as? HTTPURLResponse,
              (200...299).contains(httpResp.statusCode) else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    private func createRequest(
        path: String,
        httpMethod: String,
        headers: [String: String]? = nil
    ) -> URLRequest {
        var req = URLRequest(url: baseUrl.appendingPathComponent(path))
        
        req.httpMethod = httpMethod
        headers?.forEach { key, value in
            req.setValue(value, forHTTPHeaderField: key)
        }
        
        return req
    }
}
