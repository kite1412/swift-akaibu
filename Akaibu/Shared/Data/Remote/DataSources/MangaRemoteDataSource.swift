//
//  MangaRemoteDataSource.swift
//  Akaibu
//
//  Created by kite1412 on 31/12/25.
//

protocol MangaRemoteDataSource {
    func fetchMangaBases(title: String) async throws -> PaginatedResult<[MangaBase]>
    func fetchMangaRanks(limit: Int) async throws -> PaginatedResult<[MediaRank]>
    func fetchUserMangaList(status: UserMangaStatus?) async throws -> PaginatedResult<[UserManga]>
}
