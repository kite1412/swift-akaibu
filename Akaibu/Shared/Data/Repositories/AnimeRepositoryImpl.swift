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
    
    func getAnimeRanks(limit: Int) async throws -> PaginatedResult<[MediaRank]> {
        try await remoteDataSource.fetchAnimeRanks(limit: limit)
    }
    
    func getAnimeSuggestions() async throws -> PaginatedResult<[AnimeBase]> {
        try await remoteDataSource.fetchAnimeSuggestions()
    }
    
    func getUserAnimeList(status: UserAnimeStatus?) async throws -> PaginatedResult<[UserAnime]> {
        try await remoteDataSource.fetchUserAnimeList(status: status)
    }
    
    func updateUserAnimeProgress(animeId: Int, with progress: UserAnimeProgress) async throws -> UserAnimeProgress {
        try await remoteDataSource.updateUserAnimeProgress(animeId: animeId, with: progress)
    }
}
