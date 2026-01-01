//
//  AuthRemoteDataSource.swift
//  Akaibu
//
//  Created by kite1412 on 28/12/25.
//

import AuthenticationServices

/// A remote authentication service that implements the OAuth 2.0 Authorization Code Grant Flow.
protocol AuthRemoteDataSource {
    func requestCode(_ context: ASWebAuthenticationPresentationContextProviding, callback: @escaping (_ code: String) -> Void)
    
    func exchangeCode(_ code: String) async throws -> Token
    
    func refreshToken(_ refreshToken: String) async throws -> Token
}
