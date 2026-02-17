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
    
    func updateConsumedUnits(for media: UserMediaData, with consumedUnits: Int) async throws -> UserMediaData {
        if media.userMediaProgress.status != UserAnimeStatus.completed.rawValue {
            return try await updateUserAnimeProgress(for: media, totalEpisodesWatched: consumedUnits)
        } else {
            return media
        }
    }
    
    func updateScore(for media: UserMediaData, with score: Int) async throws -> UserMediaData {
        try await updateUserAnimeProgress(for: media, score: score)
    }
    
    func updateStatus(for media: UserMediaData, with status: String) async throws -> UserMediaData {
        try await updateUserAnimeProgress(
            for: media,
            status: status,
            totalEpisodesWatched: status == UserAnimeStatus.completed.rawValue ? media.totalUnits != nil ? media.totalUnits! : nil : nil
        )
    }
    
    private func updateUserAnimeProgress(
        for media: UserMediaData,
        status: String? = nil,
        totalEpisodesWatched: Int? = nil,
        score: Int? = nil
    ) async throws -> UserMediaData {
        let res = try await repository.updateUserAnimeProgress(
            animeId: media.id,
            with: newProgress(
                media: media,
                status: status,
                totalEpisodesWatched: totalEpisodesWatched,
                score: score
            )
        )
        
        return media.applying { data in
            data.userMediaProgress.status = status ?? data.userMediaProgress.status
            data.userMediaProgress.consumedUnits = totalEpisodesWatched ?? data.userMediaProgress.consumedUnits
            data.userMediaProgress.score = score ?? data.userMediaProgress.score
            data.userMediaProgress.updatedAt = res.updatedAt
        }
    }
    
    private func newProgress(
        media: UserMediaData,
        status: String? = nil,
        totalEpisodesWatched: Int? = nil,
        score: Int? = nil
    ) -> UserAnimeProgress {
        UserAnimeProgress(
            status: UserAnimeStatus(rawValue: status ?? media.userMediaProgress.status)!,
            score: score ?? media.userMediaProgress.score,
            totalEpisodesWatched: totalEpisodesWatched ?? media.userMediaProgress.consumedUnits,
            updatedAt: Date()
        )
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
