//
//  MangaRankingService.swift
//  Akaibu
//
//  Created by kite1412 on 22/02/26.
//

struct MangaRankingService: MediaRankingService {
    private let repository = DIContainer.shared.mangaRepository
    
    func getMediaRanking() async throws -> PaginatedResult<[MediaRank]> {
        try await repository.getMangaRanks(limit: 200)
    }
}
