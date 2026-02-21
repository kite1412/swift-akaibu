//
//  MangaRepositoryImpl.swift
//  Akaibu
//
//  Created by kite1412 on 31/12/25.
//

class MangaRepositoryImpl: MangaRepository {
    private let remoteDataSource: MangaRemoteDataSource
    
    init(remoteDataSource: MangaRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getMangaBases(title: String, params: [String: String]?) async throws -> PaginatedResult<[MangaBase]> {
        try await remoteDataSource.fetchMangaBases(title: title, params: params)
    }
    
    func getMangaRanks(limit: Int, params: [String: String]?) async throws -> PaginatedResult<[MediaRank]> {
        try await remoteDataSource.fetchMangaRanks(limit: limit, params: params)
    }
    
    func getUserMangaList(status: UserMangaStatus?, params: [String: String]?) async throws -> PaginatedResult<[UserManga]> {
        try await remoteDataSource.fetchUserMangaList(status: status, params: params)
    }
    
    func getMangaByGenres(_ genres: [Genre]) async throws -> PaginatedResult<[MangaBase]> {
        try await remoteDataSource.fetchMangaByGenres(genres)
    }
    
    func getMangaDetail(withId mangaId: Int) async throws -> MangaDetail {
        try await remoteDataSource.fetchMangaDetail(mangaId: mangaId)
    }
    
    func getMangaGenres() async throws -> [Genre] {
        try await remoteDataSource.fetchMangaGenres()
    }
    
    func updateUserMangaProgress(mangaId: Int, with progress: UserMangaProgress) async throws -> UserMangaProgress {
        try await remoteDataSource.updateUserMangaProgress(mangaId: mangaId, with: progress)
    }
    
    func deleteUserMangaProgress(withId mangaId: Int) async throws -> Bool {
        try await remoteDataSource.deleteUserMangaProgress(mangaId: mangaId)
    }
}
