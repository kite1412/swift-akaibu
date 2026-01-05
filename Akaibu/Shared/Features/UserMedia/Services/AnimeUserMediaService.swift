//
//  AnimeUserMediaService.swift
//  Akaibu
//
//  Created by kite1412 on 05/01/26.
//

class AnimeUserMediaService: UserMediaService {
    private let repository = DIContainer.shared.animeRepository
    private let mapper = PaginatedResultMapper()
    
    func getUserMediaList(status: String?) async throws -> PaginatedResult<[UserMediaData]> {
        let res = try await repository.getUserAnimeList(status: UserAnimeStatusMapper.status(from: status))
        return mapper.mapResult(res)
    }
    
    func updateConsumedUnits(for media: UserMediaData, with consumedUnits: Int) async throws -> UserMediaData {
        media
    }
    
    func updateScore(for media: UserMediaData, with score: Int) async throws -> UserMediaData {
        media
    }
    
    private class PaginatedResultMapper: PaginatedResultUserMediaMapper {
        func mapResult(_ result: PaginatedResult<[UserAnime]>) -> PaginatedResult<[UserMediaData]> {
            PaginatedResult(
                data: result.data.map { anime in
                    anime.toUserMediaData()
                },
                next: { [weak self] in
                    if let res = try await result.next?() {
                        return self?.mapResult(res)
                    } else {
                        return nil
                    }
                }
            )
        }
    }
}
