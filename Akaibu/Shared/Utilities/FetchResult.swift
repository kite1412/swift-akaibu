//
//  FetchResult.swift
//  Akaibu
//
//  Created by kite1412 on 30/12/25.
//

enum FetchResult<T> {
    case failure(Error)
    case success(data: T)
    case loading
}
