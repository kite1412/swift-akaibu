//
//  UserMediaService.swift
//  Akaibu
//
//  Created by kite1412 on 04/01/26.
//

protocol UserMediaService {
    func getUserMediaList(status: String?, params: [String: String]?) async throws -> PaginatedResult<[UserMediaData]>
    func updateConsumedUnits(for media: UserMediaData, with consumedUnits : Int) async throws -> UserMediaData
    func updateScore(for media: UserMediaData, with score: Int) async throws -> UserMediaData
    func updateStatus(for media: UserMediaData, with status: String) async throws -> UserMediaData
}
