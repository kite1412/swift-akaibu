//
//  AnimeRankingService.swift
//  Akaibu
//
//  Created by kite1412 on 22/02/26.
//

struct AnimeRankingService: MediaRankingService {
    private let repository = DIContainer.shared.animeRepository
    
    func getMediaRanking() async throws -> PaginatedResult<[MediaRank]> {
        try await repository.getAnimeRanks(limit: 20)
    }
}
