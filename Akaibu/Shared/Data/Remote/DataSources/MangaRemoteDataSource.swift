//
//  MangaRemoteDataSource.swift
//  Akaibu
//
//  Created by kite1412 on 31/12/25.
//

protocol MangaRemoteDataSource {
    func fetchMangaBases(title: String, params: [String: String]?) async throws -> PaginatedResult<[MangaBase]>
    func fetchMangaRanks(limit: Int, params: [String: String]?) async throws -> PaginatedResult<[MediaRank]>
    func fetchUserMangaList(status: UserMangaStatus?, params: [String: String]?) async throws -> PaginatedResult<[UserManga]>
    func fetchMangaDetail(mangaId: Int) async throws -> MangaDetail
    func updateUserMangaProgress(mangaId: Int, with progress: UserMangaProgress) async throws -> UserMangaProgress
}
