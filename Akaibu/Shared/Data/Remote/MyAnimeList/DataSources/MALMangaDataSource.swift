//
//  MALMangaDataSource.swift
//  Akaibu
//
//  Created by kite1412 on 31/12/25.
//

class MALMangaDataSource: MangaRemoteDataSource {
    private let client: MALHttpClient = .shared
    private let paginator: MALPaginator = .shared
    
    func fetchMangaRanks(limit: Int) async throws -> PaginatedResult<[MediaRank]> {
        let res: PaginatedResult<MALMangaRanking> = try await paginator.getPaginated(
            path: MALPaths.mangaRanking,
            headers: nil,
            params: [
                "fields": MALMangaFields.rank,
                "limit": String(limit)
            ]
        )
        
        return res.toDomain()
    }
}
