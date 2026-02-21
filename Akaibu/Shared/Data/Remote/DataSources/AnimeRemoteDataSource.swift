//
//  AnimeRemoteDataSource.swift
//  Akaibu
//
//  Created by kite1412 on 30/12/25.
//

protocol AnimeRemoteDataSource {
    func fetchAnimeBases(title: String, params: [String: String]?) async throws -> PaginatedResult<[AnimeBase]>
    func fetchAnimeRanks(limit: Int, params: [String: String]?) async throws -> PaginatedResult<[MediaRank]>
    func fetchAnimeSuggestions(params: [String: String]?) async throws -> PaginatedResult<[AnimeBase]>
    func fetchUserAnimeList(status: UserAnimeStatus?, params: [String: String]?) async throws -> PaginatedResult<[UserAnime]>
    func fetchAnimeDetail(animeId: Int) async throws -> AnimeDetail
    func fetchAnimeSchedules(day: Day) async throws -> PaginatedResult<[AnimeSchedule]>
    func fetchAnimeGenres() async throws -> [Genre]
    func updateUserAnimeProgress(animeId: Int, with progress: UserAnimeProgress) async throws -> UserAnimeProgress
    func deleteUserAnimeProgress(animeId: Int) async throws -> Bool
}
