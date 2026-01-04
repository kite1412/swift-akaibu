//
//  MockUserMediaService.swift
//  Akaibu
//
//  Created by kite1412 on 04/01/26.
//

class MockUserMediaService: UserMediaService {
    func getUserMediaList(status: String?) async throws -> PaginatedResult<[UserMediaData]> {
        PaginatedResult(
            data: [userMediaData, userMediaDataMinimum],
            next: nil
        )
    }
    
    func updateConsumedUnits(for media: UserMediaData, with consumedUnits: Int) async throws -> UserMediaData {
        media.applying { data in
            data.consumedUnits = consumedUnits
        }
    }
    
    func updateScore(for media: UserMediaData, with score: Int) async throws -> UserMediaData {
        media.applying { data in
            data.userScore = score
        }
    }
}
