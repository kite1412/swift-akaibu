//
//  UserMediaService+Overload.swift
//  Akaibu
//
//  Created by kite1412 on 11/02/26.
//

extension UserMediaService {
    func getUserMediaList(status: String?) async throws -> PaginatedResult<[UserMediaData]> {
        try await getUserMediaList(status: status, params: nil)
    }
}
