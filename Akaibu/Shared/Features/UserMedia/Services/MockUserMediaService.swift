//
//  MockUserMediaService.swift
//  Akaibu
//
//  Created by kite1412 on 04/01/26.
//

class MockUserMediaService: UserMediaService {
    func navigateToDetail(withId mediaId: Int, router: AppRouter) {}
    
    func getUserMediaList(status: String?, params: [String: String]? = nil) async throws -> PaginatedResult<[UserMediaData]> {
        PaginatedResult(
            data: [userMediaData, userMediaDataMinimum],
            next: nil
        )
    }
    
    func updateProgress(for media: UserMediaData, with newProgress: UserMediaProgress) async throws -> UserMediaData {
        media.applying { data in
            data.userMediaProgress = newProgress
        }
    }
}
