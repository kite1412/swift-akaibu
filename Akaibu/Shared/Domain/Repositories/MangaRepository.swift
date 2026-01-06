//
//  MangaRepository.swift
//  Akaibu
//
//  Created by kite1412 on 31/12/25.
//

protocol MangaRepository {
    func getMangaBases(title: String) async throws -> PaginatedResult<[MangaBase]>
    func getMangaRanks(limit: Int) async throws -> PaginatedResult<[MediaRank]>
    func getUserMangaList(status: UserMangaStatus?) async throws -> PaginatedResult<[UserManga]>
}
