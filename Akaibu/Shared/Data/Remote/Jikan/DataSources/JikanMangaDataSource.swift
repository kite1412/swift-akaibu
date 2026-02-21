//
//  JikanMangaDataSource.swift
//  Akaibu
//
//  Created by kite1412 on 20/02/26.
//

struct JikanMangaDataSource {
    private let client: JikanHTTPClient = .shared
    private let paginator: JikanPaginator = .shared
    
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
    
    func fetchMangaByGenres(_ genres: [Genre]) async throws -> PaginatedResult<[MangaBase]> {
        let res: PaginatedResult<JikanMangaList> = try await paginator.getPaginated(
            path: JikanPaths.manga,
            headers: nil,
            params: [
                "genres": genres.map { genre in
                    String(genre.id)
                }.joined(separator: ","),
                "sort": "desc",
                "order_by": "scored_by"
            ]
        )
        
        return res.toMangaBases()
    }
}
