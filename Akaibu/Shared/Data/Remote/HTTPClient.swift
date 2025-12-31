//
//  HTTPClient.swift
//  Akaibu
//
//  Created by kite1412 on 27/12/25.
//

import Foundation

class HTTPClient {
    let baseURL: URL
    private let session: URLSession
    
    init(baseURL: URL, session: URLSession = .shared) {
        var url = baseURL
        if !url.absoluteString.hasSuffix("/") {
            url = url.appendingPathComponent("/")
        }
        self.baseURL = url
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
    
    func perform<T: Decodable>(_ request: URLRequest) async throws -> T {
        let (data, response) = try await session.data(for: request)
        guard let httpResp = response as? HTTPURLResponse, (200...299).contains(httpResp.statusCode) else {
            throw URLError(.badServerResponse)
        }
        return try API.decode(T.self, from: data)
    }
    
    func createRequest(
        path: String,
        httpMethod: String,
        headers: [String: String]? = nil,
        params: [String: String]? = nil
    ) -> URLRequest {
        var components = URLComponents(string: baseURL.absoluteString + path)
        if let params = params {
            components?.queryItems = params.map { q in
                URLQueryItem(name: q.key, value: q.value)
            }
        }
        
        let url = components?.url ?? baseURL.appending(path: path)
        var req = URLRequest(url: url)
        req.httpMethod = httpMethod
        headers?.forEach { key, value in
            req.setValue(value, forHTTPHeaderField: key)
        }
        
        return req
    }
    
    func createAuthenticatedRequest(
        path: String,
        httpMethod: String,
        headers: [String: String]? = nil,
        params: [String: String]? = nil
    ) -> URLRequest {
        var req = createRequest(
            path: path,
            httpMethod: httpMethod,
            headers: headers,
            params: params
        )
        req.attachBearerToken()
        
        return req
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
        req.httpBody = try API.encode(body)
        
        return try await perform(req)
    }
}
