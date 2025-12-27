//
//  DIContainer.swift
//  Akaibu
//
//  Created by kite1412 on 28/12/25.
//

struct DIContainer {
    static let shared = DIContainer()
    
    let authRemoteDataSource: AuthRemoteDataSource = MALAuthDataSource()
    
    private init() {}
}
