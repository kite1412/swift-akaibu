//
//  MockUserMediaService.swift
//  Akaibu
//
//  Created by kite1412 on 04/01/26.
//

class MockUserMediaService: UserMediaService {
    func getUserMediaList(status: String?, params: [String: String]? = nil) async throws -> PaginatedResult<[UserMediaData]> {
        PaginatedResult(
            data: [userMediaData, userMediaDataMinimum],
            next: nil
        )
    }
    
    func updateConsumedUnits(for media: UserMediaData, with consumedUnits: Int) async throws -> UserMediaData {
        media.applying { data in
            data.userMediaProgress.consumedUnits = consumedUnits
        }
    }
    
    func updateScore(for media: UserMediaData, with score: Int) async throws -> UserMediaData {
        media.applying { data in
            data.userMediaProgress.score = score
        }
    }
    
    func updateStatus(for media: UserMediaData, with status: String) async throws -> UserMediaData {
        media.applying { data in
            data.userMediaProgress.status = status
        }
    }
}
