//
//  MALAnimeDataSource.swift
//  Akaibu
//
//  Created by kite1412 on 30/12/25.
//

struct MALAnimeDataSource: AnimeRemoteDataSource {
    private let client: MALHTTPClient = .shared
    private let paginator: MALPaginator = .shared
    private let jikanAnimeDataSource: JikanAnimeDataSource = .shared
    
    func fetchAnimeBases(title: String, params: [String: String]?) async throws -> PaginatedResult<[AnimeBase]> {
        let res: PaginatedResult<MALAnimeList> = try await paginator.getPaginated(
            path: MALPaths.anime,
            headers: nil,
            params: client.mergeParams(
                client.withDefaultGetMediaParams(
                    [
                        "q": title,
                        "fields": MALAnimeFields.base
                    ]
                ),
                params
            )
        )
        
        return res.toDomain()
    }
    
    func fetchAnimeRanks(limit: Int, params: [String: String]?) async throws -> PaginatedResult<[MediaRank]> {
        let res: PaginatedResult<MALAnimeRanking> = try await paginator.getPaginated(
            path: MALPaths.animeRanking,
            headers: nil,
            params: client.mergeParams(
                client.withDefaultGetMediaParams(
                    [
                        "ranking_type": "all",
                        "fields": MALAnimeFields.rank,
                        "limit": String(limit)
                    ]
                ),
                params
            )
        )
        
        return res.toDomain()
    }
    
    func fetchAnimeSuggestions(params: [String: String]?) async throws -> PaginatedResult<[AnimeBase]> {
        let res: PaginatedResult<MALAnimeList> = try await paginator.getPaginated(
            path: MALPaths.animeSuggestions,
            headers: nil,
            params: client.mergeParams(
                client.withDefaultGetMediaParams(
                    ["fields": MALAnimeFields.base]
                ),
                params
            )
        )
        
        return res.toDomain()
    }
    
    func fetchUserAnimeList(status: UserAnimeStatus?, params: [String: String]?) async throws -> PaginatedResult<[UserAnime]> {
        let res: PaginatedResult<MALUserAnimeList> = try await paginator.getPaginated(
            path: MALPaths.userAnimeList,
            headers: nil,
            params: client.mergeParams(
                client.withDefaultGetMediaParams(
                    [
                        "fields": MALAnimeFields.userAnime,
                        "status": status?.toMALUserAnimeStatus().rawValue ?? ""
                    ]
                ),
                params
            )
        )
        
        return res.toDomain()
    }
    
    func fetchAnimeDetail(animeId: Int) async throws -> AnimeDetail {
        let req = client.createAuthenticatedRequest(
            path: MALPaths.animeDetail(id: animeId),
            httpMethod: "GET",
            params: ["fields": MALAnimeFields.detail]
        )
        let res: MALAnimeDetail = try await client.perform(req)
        
        return res.toDomain(characters: try await jikanAnimeDataSource.fetchAnimeCharacters(byId: animeId))
    }
    
    func fetchAnimeSchedules(day: Day) async throws -> PaginatedResult<[AnimeSchedule]> {
        try await jikanAnimeDataSource.fetchAnimeSchedules(day: day)
    }
    
    func fetchAnimeGenres() async throws -> [Genre] {
        try await jikanAnimeDataSource.fetchAnimeGenres()
    }
    
    func updateUserAnimeProgress(animeId: Int, with progress: UserAnimeProgress) async throws -> UserAnimeProgress {
        let res: MALUserAnimeListStatus = try await client.performFormURLEncodedRequest(
            path: MALPaths.updateAnimeListStatus(id: animeId),
            httpMethod: "PATCH",
            parameters: progress.toFormURLEncoded()
        )
        
        return res.toDomain()
    }
    
    func deleteUserAnimeProgress(animeId: Int) async throws -> Bool {
        let req = client.createAuthenticatedRequest(
            path: MALPaths.animeListStatus(id: animeId),
            httpMethod: "DELETE"
        )
        try await client.performIgnoreResponse(req)
        
        return true
    }
}
