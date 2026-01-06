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
    
    func getMangaBases(title: String) async throws -> PaginatedResult<[MangaBase]> {
        try await remoteDataSource.fetchMangaBases(title: title)
    }
    
    func getMangaRanks(limit: Int) async throws -> PaginatedResult<[MediaRank]> {
        try await remoteDataSource.fetchMangaRanks(limit: limit)
    }
    
    func getUserMangaList(status: UserMangaStatus?) async throws -> PaginatedResult<[UserManga]> {
        try await remoteDataSource.fetchUserMangaList(status: status)
    }
    
    func updateUserMangaProgress(mangaId: Int, with progress: UserMangaProgress) async throws -> UserMangaProgress {
        try await remoteDataSource.updateUserMangaProgress(mangaId: mangaId, with: progress)
    }
}
