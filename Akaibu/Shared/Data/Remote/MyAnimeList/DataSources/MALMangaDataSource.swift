//
//  MALMangaDataSource.swift
//  Akaibu
//
//  Created by kite1412 on 31/12/25.
//

class MALMangaDataSource: MangaRemoteDataSource {
    private let client: MALHttpClient = .shared
    private let paginator: MALPaginator = .shared
    
    func fetchMangaBases(title: String, params: [String: String]?) async throws -> PaginatedResult<[MangaBase]> {
        let res: PaginatedResult<MALMangaList> = try await paginator.getPaginated(
            path: MALPaths.manga,
            headers: nil,
            params: client.mergeParams(
                [
                    "fields": MALMangaFields.base,
                    "q": title
                ],
                params
            )
        )
        
        return res.toDomain()
    }
    
    func fetchMangaRanks(limit: Int, params: [String: String]?) async throws -> PaginatedResult<[MediaRank]> {
        let res: PaginatedResult<MALMangaRanking> = try await paginator.getPaginated(
            path: MALPaths.mangaRanking,
            headers: nil,
            params: client.mergeParams(
                [
                    "fields": MALMangaFields.rank,
                    "limit": String(limit)
                ],
                params
            )
        )
        
        return res.toDomain()
    }
    
    func fetchUserMangaList(status: UserMangaStatus?, params: [String: String]?) async throws -> PaginatedResult<[UserManga]> {
        let res: PaginatedResult<MALUserMangaList> = try await paginator.getPaginated(
            path: MALPaths.userMangaList,
            headers: nil,
            params: client.mergeParams(
                [
                    "fields": MALMangaFields.userManga,
                    "status": status?.toMALUserMangaStatus().rawValue ?? ""
                ],
                params
            )
        )
        
        return res.toDomain()
    }
    
    func fetchMangaDetail(mangaId: Int) async throws -> MangaDetail {
        let req = client.createAuthenticatedRequest(
            path: MALPaths.mangaDetail(id: mangaId),
            httpMethod: "GET",
            params: ["fields": MALMangaFields.detail]
        )
        let res: MALMangaDetail = try await client.perform(req)
        
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
