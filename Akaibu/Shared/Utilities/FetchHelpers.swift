//
//  FetchHelpers.swift
//  Akaibu
//
//  Created by kite1412 on 31/12/25.
//

struct FetchHelpers {
    private init() {}
    
    static func tryFetch<T>(_ block: () async throws -> T) async -> FetchResult<T> {
        do {
            let res = try await block()
            return .success(data: res)
        } catch {
            return .failure(error)
        }
    }
}
