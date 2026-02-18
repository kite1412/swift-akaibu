//
//  AnimeUserMediaService.swift
//  Akaibu
//
//  Created by kite1412 on 05/01/26.
//

import Foundation

class AnimeUserMediaService: UserMediaService {
    private let repository = DIContainer.shared.animeRepository
    private let mapper = PaginatedResultMapper()
    
    func navigateToDetail(withId mediaId: Int, router: AppRouter) {
        router.goToAnimeDetail(withId: mediaId)
    }
    
    func getUserMediaList(status: String?, params: [String: String]?) async throws -> PaginatedResult<[UserMediaData]> {
        let res = try await repository.getUserAnimeList(status: UserAnimeStatusMapper.status(from: status), params: params)
        return mapper.mapResult(res)
    }
    
    func updateProgress(for media: UserMediaData, with newProgress: UserMediaProgress) async throws -> UserMediaData {
        let res = try await repository.updateUserAnimeProgress(
            animeId: media.id,
            with: UserAnimeProgress(
                status: UserAnimeStatus(rawValue: newProgress.status)!,
                score: newProgress.score,
                totalEpisodesWatched: newProgress.consumedUnits,
                updatedAt: Date()
            )
        )
        
        return media.applying { data in
            data.userMediaProgress = res.toUserMediaProgress()
        }
    }
    
    private class PaginatedResultMapper: PaginatedResultUserMediaMapper {
        func mapResult(_ result: PaginatedResult<[UserAnime]>) -> PaginatedResult<[UserMediaData]> {
            let next = result.next != nil ? { [weak self] in
                if let res = try await result.next?() {
                    return self?.mapResult(res)
                } else {
                    return nil
                }
            } : nil
            
            return PaginatedResult(
                data: result.data.map { anime in
                    anime.toUserMediaData()
                },
                next: next
            )
        }
    }
}
