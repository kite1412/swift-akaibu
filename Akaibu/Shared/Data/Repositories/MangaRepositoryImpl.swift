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
    
    func getMangaRanks() async throws -> [MediaRank] {
        try await remoteDataSource.fetchMangaRanks()
    }
}
