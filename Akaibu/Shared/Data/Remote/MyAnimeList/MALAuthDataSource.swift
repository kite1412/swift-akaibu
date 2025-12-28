//
//  MALAuthDataSource.swift
//  Akaibu
//
//  Created by kite1412 on 27/12/25.
//

import Foundation
import AuthenticationServices
import OSLog

class MALAuthDataSource: AuthRemoteDataSource {
    private let client = HTTPClient(baseURL: URL.init(string: "https://myanimelist.net/v1/oauth2/")!)
    
    func requestCode(
        _ context: ASWebAuthenticationPresentationContextProviding,
        callback: @escaping (_ code: String) -> Void
    ) {
        var components = URLComponents(string: client.baseURL.absoluteString)
        components?.queryItems = [
            URLQueryItem(name: "client_id", value: Secrets.malClientId),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "redirect_uri", value: "akaibu://auth-callback"),
            URLQueryItem(name: "code_challenge", value: Secrets.codeVerifier)
        ]
        
        let url = components!.url!
        
        let session = ASWebAuthenticationSession(
            url: url,
            callback: ASWebAuthenticationSession.Callback.customScheme("akaibu://auth-callback")
        ) { callbackURL, error in
            guard let callbackURL else {
                AppLogger.auth.debug("callbackURL is nil")
                return
            }
            
            let code = URLComponents(string: callbackURL.absoluteString)?
                .queryItems?
                .first(where: { $0.name == "code" })?.value
            
            if let code {
                callback(code)
            } else {
                AppLogger.auth.debug("authorization code is nil")
            }
        }
        
        session.presentationContextProvider = context
        session.start()
    }
    
    func exchangeCode(_ authorizationCode: String) async throws -> Token {
        try await performTokenRequest(
            bodyParams: [
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
            bodyParams: [
                "grant_type": "refresh_token",
                "refresh_token": refreshToken,
                "client_id": Secrets.malClientId,
                "client_secret": Secrets.malClientSecret
            ]
        )
    }
    
    private func performTokenRequest<T: Decodable>(
        bodyParams: [String: String]
    ) async throws -> T {
        var req = client.createRequest(path: "token", httpMethod: "POST")
        let paramArray = bodyParams.map { key, value in
            "\(key)=\(value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        }
        let postData = paramArray.joined(separator: "&").data(using: .utf8)!
        
        req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        req.httpBody = postData
        
        return try await client.perform(req)
    }
}
