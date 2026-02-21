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
        let res: PaginatedResult<JikanAnimeList> = try await paginator.getPaginated(path: JikanPaths.animeSchedules(day))
        
        return res.toAnimeSchedules()
    }
    
    func fetchAnimeGenres() async throws -> [String] {
        let res: JikanGenres = try await client.get(JikanPaths.animeGenres)
        
        return res.toStrings()
    }
}
