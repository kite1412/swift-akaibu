//
//  JikanAnimeDataSource.swift
//  Akaibu
//
//  Created by kite1412 on 20/02/26.
//

struct JikanAnimeDataSource {
    private let client: JikanHTTPClient = .shared
    private let paginator: JikanPaginator = .shared
    
    static let shared = JikanAnimeDataSource()
    
    private init() {}
    
    func fetchAnimeCharacters(byId animeId: Int) async throws -> [Character] {
        let res: JikanMediaCharacters = try await client.get(JikanPaths.animeCharacters(animeId: animeId))
        
        return res.toDomain()
    }
    
    func fetchAnimeSchedules(day: Day) async throws -> PaginatedResult<[AnimeSchedule]> {
        let res: PaginatedResult<JikanAnimeList> = try await paginator.getPaginated(
            path: JikanPaths.animeSchedules,
            params: [
                "filter": day.rawValue
            ]
        )
        
        return res.toAnimeSchedules()
    }
    
    func fetchAnimeGenres() async throws -> [Genre] {
        let res: JikanGenres = try await client.get(JikanPaths.animeGenres)
        
        return res.toDomain()
    }
    
    func fetchAnimeByGenres(_ genres: [Genre]) async throws -> PaginatedResult<[AnimeBase]> {
        let res: PaginatedResult<JikanAnimeList> = try await paginator.getPaginated(
            path: JikanPaths.anime,
            headers: nil,
            params: [
                "genres": genres.map { genre in
                    String(genre.id)
                }.joined(separator: ","),
                "sort": "desc",
                "order_by": "members"
            ]
        )
        
        return res.toAnimeBases()
    }
}
