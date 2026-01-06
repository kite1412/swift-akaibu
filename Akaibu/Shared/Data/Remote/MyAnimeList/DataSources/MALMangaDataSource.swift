//
//  MALMangaDataSource.swift
//  Akaibu
//
//  Created by kite1412 on 31/12/25.
//

class MALMangaDataSource: MangaRemoteDataSource {
    private let client: MALHttpClient = .shared
    private let paginator: MALPaginator = .shared
    
    func fetchMangaBases(title: String) async throws -> PaginatedResult<[MangaBase]> {
        let res: PaginatedResult<MALMangaList> = try await paginator.getPaginated(
            path: MALPaths.manga,
            headers: nil,
            params: [
                "fields": MALMangaFields.base,
                "q": title
            ]
        )
        
        return res.toDomain()
    }
    
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
    
    func fetchUserMangaList(status: UserMangaStatus?) async throws -> PaginatedResult<[UserManga]> {
        let res: PaginatedResult<MALUserMangaList> = try await paginator.getPaginated(
            path: MALPaths.userMangaList,
            headers: nil,
            params: [
                "fields": MALMangaFields.userManga,
                "status": status?.toMALUserMangaStatus().rawValue ?? ""
            ]
        )
        
        return res.toDomain()
    }
    
    func updateUserMangaProgress(mangaId: Int, with progress: UserMangaProgress) async throws -> UserMangaProgress {
        let res: MALUserMangaListStatus = try await client.performFormURLEncodedRequest(
            path: MALPaths.updateMangaListStatus(id: mangaId),
            httpMethod: "PATCH",
            parameters: progress.toFormURLEncoded()
        )
        
        return res.toDomain()
    }
}
