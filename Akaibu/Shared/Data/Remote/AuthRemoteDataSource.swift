//
//  AuthRemoteDataSource.swift
//  Akaibu
//
//  Created by kite1412 on 28/12/25.
//

protocol AuthRemoteDataSource {
    func exchangeCode(_ code: String) async throws -> Token
    
    func refreshToken(_ refreshToken: String) async throws -> Token
}
