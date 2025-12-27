//
//  MALAuthDataSource.swift
//  Akaibu
//
//  Created by kite1412 on 27/12/25.
//

import Foundation

class MALAuthDataSource: AuthRemoteDataSource {
    private let client = HTTPClient(baseURL: URL.init(string: "https://myanimelist.net/v1/oauth2/")!)
    
    func exchangeCode(_ authorizationCode: String) async throws -> Token {
        try await performTokenRequest(
            params: [
                "grant_type": "authorization_code",
                "client_id": Secrets.malClientId,
                "client_secret": Secrets.malClientSecret,
                "code": authorizationCode,
                "redirect_uri": "akaibu://auth-callback",
                "code_verifier": Secrets.codeVerifier
            ]
        )
    }
    
    func refreshToken(_ refreshToken: String) async throws -> Token {
        try await performTokenRequest(
            params: [
                "grant_type": "refresh_token",
                "refresh_token": refreshToken,
                "client_id": Secrets.malClientId,
                "client_secret": Secrets.malClientSecret
            ]
        )
    }
    
    private func performTokenRequest<T: Decodable>(
        params: [String: String]
    ) async throws -> T {
        var req = client.createRequest(path: "token", httpMethod: "POST")
        let paramArray = params.map { key, value in
            "\(key)=\(value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        }
        let postData = paramArray.joined(separator: "&").data(using: .utf8)!
        
        req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        req.httpBody = postData
        
        return try await client.perform(req)
    }
}
