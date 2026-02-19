//
//  JikanAnimeDataSource.swift
//  Akaibu
//
//  Created by kite1412 on 20/02/26.
//

class JikanAnimeDataSource {
    private let client: JikanHTTPClient = .shared
    
    static let shared = JikanAnimeDataSource()
    
    private init() {}
    
    func getAnimeCharacters(byId animeId: Int) async throws -> [Character] {
        let res: JikanMediaCharacters = try await client.get(JikanPaths.animeCharacters(animeId: animeId))
        
        return res.toDomain()
    }
}
