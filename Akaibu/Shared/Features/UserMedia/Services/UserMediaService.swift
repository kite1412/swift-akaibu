//
//  UserMediaService.swift
//  Akaibu
//
//  Created by kite1412 on 04/01/26.
//

protocol UserMediaService {
    func navigateToDetail(withId mediaId: Int, router: AppRouter)
    func getUserMediaList(status: String?, params: [String: String]?) async throws -> PaginatedResult<[UserMediaData]>
    func updateProgress(for media: UserMediaData, with newProgress: UserMediaProgress) async throws -> UserMediaData
}
