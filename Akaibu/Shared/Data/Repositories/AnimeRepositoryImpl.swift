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
    
    func getAnimeBases(title: String) async throws -> PaginatedResult<[AnimeBase]> {
        try await remoteDataSource.fetchAnimeBases(title: title)
    }
    
    func getAnimeRanks() async throws -> PaginatedResult<[MediaRank]> {
        try await remoteDataSource.fetchAnimeRanks()
    }
    
    func getAnimeSuggestions() async throws -> PaginatedResult<[AnimeBase]> {
        try await remoteDataSource.fetchAnimeSuggestions()
    }
}
