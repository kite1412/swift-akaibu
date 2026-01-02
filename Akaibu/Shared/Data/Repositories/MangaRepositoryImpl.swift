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
}
