//
//  JikanMangaDataSource.swift
//  Akaibu
//
//  Created by kite1412 on 20/02/26.
//

struct JikanMangaDataSource {
    private let client: JikanHTTPClient = .shared
    
    static let shared = JikanMangaDataSource()
    
    private init() {}
    
    func fetchMangaCharacters(byId mangaId: Int) async throws -> [Character] {
        let res: JikanMediaCharacters = try await client.get(JikanPaths.mangaCharacters(mangaId: mangaId))
        
        return res.toDomain()
    }
    
    func fetchMangaGenres() async throws -> [Genre] {
        let res: JikanGenres = try await client.get(JikanPaths.mangaGenres)
        
        return res.toDomain()
    }
}
