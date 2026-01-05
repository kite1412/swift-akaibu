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
    
    func fetchAnimeRanks(limit: Int) async throws -> PaginatedResult<[MediaRank]> {
        let res: PaginatedResult<MALAnimeRanking> = try await paginator.getPaginated(
            path: MALPaths.animeRanking,
            headers: nil,
            params: [
                "ranking_type": "all",
                "fields": MALAnimeFields.rank,
                "limit": String(limit)
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
    
    func fetchUserAnimeList(status: UserAnimeStatus?) async throws -> PaginatedResult<[UserAnime]> {
        let res: PaginatedResult<MALUserAnimeList> = try await paginator.getPaginated(
            path: MALPaths.userAnimeList,
            headers: nil,
            params: [
                "fields": MALAnimeFields.userAnime,
                "status": status?.toMALUserAnimeStatus().rawValue ?? ""
            ]
        )
        
        return res.toDomain()
    }
    
    func updateUserAnimeProgress(for anime: UserAnime, with progress: UserAnimeProgress) async throws -> UserAnimeProgress {
        let res: MALUserAnimeListStatus = try await client.performFormURLEncodedRequest(
            path: MALPaths.updateAnimeListStatus(id: anime.id),
            httpMethod: "PATCH",
            parameters: progress.toFormURLEncoded()
        )
        
        return res.toDomain()
    }
}
