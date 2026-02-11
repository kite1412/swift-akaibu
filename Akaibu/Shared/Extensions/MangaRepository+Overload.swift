//
//  MangaRepository+Overload.swift
//  Akaibu
//
//  Created by kite1412 on 11/02/26.
//

extension MangaRepository {
    func getMangaBases(title: String) async throws -> PaginatedResult<[MangaBase]> {
        try await getMangaBases(title: title, params: nil)
    }
    
    func getMangaRanks(limit: Int) async throws -> PaginatedResult<[MediaRank]> {
        try await getMangaRanks(limit: limit, params: nil)
    }
    
    func getUserMangaList(status: UserMangaStatus?) async throws -> PaginatedResult<[UserManga]> {
        try await getUserMangaList(status: status, params: nil)
    }
}
