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
    
    func getUserMediaList(status: String?) async throws -> PaginatedResult<[UserMediaData]> {
        let res = try await repository.getUserAnimeList(status: UserAnimeStatusMapper.status(from: status))
        return mapper.mapResult(res)
    }
    
    func updateConsumedUnits(for media: UserMediaData, with consumedUnits: Int) async throws -> UserMediaData {
        try await updateUserAnimeProgress(for: media, totalEpisodesWatched: consumedUnits)
    }
    
    func updateScore(for media: UserMediaData, with score: Int) async throws -> UserMediaData {
        try await updateUserAnimeProgress(for: media, score: score)
    }
    
    func updateStatus(for media: UserMediaData, with status: String) async throws -> UserMediaData {
        try await updateUserAnimeProgress(for: media, status: status)
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
            data.userStatus = status ?? data.userStatus
            data.consumedUnits = totalEpisodesWatched ?? data.consumedUnits
            data.userScore = score ?? data.userScore
            data.updatedAt = res.updatedAt
        }
    }
    
    private func newProgress(
        media: UserMediaData,
        status: String? = nil,
        totalEpisodesWatched: Int? = nil,
        score: Int? = nil
    ) -> UserAnimeProgress {
        UserAnimeProgress(
            status: UserAnimeStatus(rawValue: status ?? media.userStatus)!,
            score: score ?? media.userScore,
            totalEpisodesWatched: totalEpisodesWatched ?? media.consumedUnits,
            updatedAt: Date()
        )
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
