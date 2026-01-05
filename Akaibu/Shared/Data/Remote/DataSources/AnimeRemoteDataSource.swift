//
//  AnimeRemoteDataSource.swift
//  Akaibu
//
//  Created by kite1412 on 30/12/25.
//

protocol AnimeRemoteDataSource {
    func fetchAnimeBases(title: String) async throws -> PaginatedResult<[AnimeBase]>
    func fetchAnimeRanks(limit: Int) async throws -> PaginatedResult<[MediaRank]>
    func fetchAnimeSuggestions() async throws -> PaginatedResult<[AnimeBase]>
    func fetchUserAnimeList(status: UserAnimeStatus?) async throws -> PaginatedResult<[UserAnime]>
    func updateUserAnimeProgress(for anime: UserAnime, with progress: UserAnimeProgress) async throws -> UserAnimeProgress
}
