//
//  JikanAnimeDataSource.swift
//  Akaibu
//
//  Created by kite1412 on 20/02/26.
//

struct JikanAnimeDataSource {
    private let client: JikanHTTPClient = .shared
    
    static let shared = JikanAnimeDataSource()
    
    private init() {}
    
    func fetchAnimeCharacters(byId animeId: Int) async throws -> [Character] {
        let res: JikanMediaCharacters = try await client.get(JikanPaths.animeCharacters(animeId: animeId))
        
        return res.toDomain()
    }
    
    func fetchAnimeSchedules(day: Day) async throws -> [AnimeBase] {
        let res: JikanAnimeList = try await client.get(JikanPaths.animeSchedules(day))
        
        return res.toAnimeBases()
    }
}
