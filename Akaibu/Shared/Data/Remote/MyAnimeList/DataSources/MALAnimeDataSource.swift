//
//  MALAnimeDataSource.swift
//  Akaibu
//
//  Created by kite1412 on 30/12/25.
//

class MALAnimeDataSource: AnimeRemoteDataSource {
    private let client: MALHttpClient = .shared
    private let paginator: MALPaginator = .shared
    
    func fetchAnimeBases(title: String) async throws -> PaginatedResult<[AnimeBase]> {
        let res: PaginatedResult<MALAnimeList> = try await paginator.getPaginated(
            path: MALPaths.anime,
            headers: nil,
            params: [
                "q": title,
                "fields": MALAnimeFields.base
            ]
        )
        
        return res.toDomain()
    }
    
    func fetchAnimeRanks() async throws -> PaginatedResult<[MediaRank]> {
        let res: PaginatedResult<MALAnimeRanking> = try await paginator.getPaginated(
            path: MALPaths.animeRanking,
            headers: nil,
            params: [
                "ranking_type": "all",
                "fields": MALAnimeFields.rank
            ]
        )
        
        return res.toDomain()
    }
    
    func fetchAnimeSuggestions() async throws -> PaginatedResult<[AnimeBase]> {
        let res: PaginatedResult<MALAnimeList> = try await paginator.getPaginated(
            path: MALPaths.animeSuggestions,
            headers: nil,
            params: [
                "fields": MALAnimeFields.base
            ]
        )
        
        return res.toDomain()
    }
}
