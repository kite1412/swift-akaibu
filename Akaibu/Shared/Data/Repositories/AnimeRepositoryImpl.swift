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
    
    func getAnimeBases(title: String, params: [String: String]?) async throws -> PaginatedResult<[AnimeBase]> {
        try await remoteDataSource.fetchAnimeBases(title: title, params: params)
    }
    
    func getAnimeRanks(limit: Int, params: [String: String]?) async throws -> PaginatedResult<[MediaRank]> {
        try await remoteDataSource.fetchAnimeRanks(limit: limit, params: params)
    }
    
    func getAnimeSuggestions(params: [String: String]?) async throws -> PaginatedResult<[AnimeBase]> {
        try await remoteDataSource.fetchAnimeSuggestions(params: params)
    }
    
    func getUserAnimeList(status: UserAnimeStatus?, params: [String: String]?) async throws -> PaginatedResult<[UserAnime]> {
        try await remoteDataSource.fetchUserAnimeList(status: status, params: params)
    }
    
    func getAnimeDetail(withId animeId: Int) async throws -> AnimeDetail {
        try await remoteDataSource.fetchAnimeDetail(animeId: animeId)
    }
    
    func updateUserAnimeProgress(animeId: Int, with progress: UserAnimeProgress) async throws -> UserAnimeProgress {
        try await remoteDataSource.updateUserAnimeProgress(animeId: animeId, with: progress)
    }
    
    func deleteUserAnimeProgress(withId animeId: Int) async throws -> Bool {
        try await remoteDataSource.deleteUserAnimeProgress(animeId: animeId)
    }
}
