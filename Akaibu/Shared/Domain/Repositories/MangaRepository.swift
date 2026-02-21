//
//  MangaRepository.swift
//  Akaibu
//
//  Created by kite1412 on 31/12/25.
//

protocol MangaRepository {
    func getMangaBases(title: String, params: [String: String]?) async throws -> PaginatedResult<[MangaBase]>
    func getMangaRanks(limit: Int, params: [String: String]?) async throws -> PaginatedResult<[MediaRank]>
    func getUserMangaList(status: UserMangaStatus?, params: [String: String]?) async throws -> PaginatedResult<[UserManga]>
    func getMangaDetail(withId mangaId: Int) async throws -> MangaDetail
    func getMangaGenres() async throws -> [String]
    func updateUserMangaProgress(mangaId: Int, with progress: UserMangaProgress) async throws -> UserMangaProgress
    func deleteUserMangaProgress(withId mangaId: Int) async throws -> Bool
}
