//
//  AnimeRepositoryImpl.swift
//  Akaibu
//
//  Created by kite1412 on 31/12/25.
//

class AnimeRepositoryImpl: AnimeRepository {
    private let remoteDataSource: AnimeRemoteDataSource
    
    init(remoteDataSource: AnimeRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getAnimeBases(title: String) async throws -> [AnimeBase] {
        try await remoteDataSource.fetchAnimeBases(title: title)
    }
    
    func getAnimeRanks() async throws -> [MediaRank] {
        try await remoteDataSource.fetchAnimeRanks()
    }
}
