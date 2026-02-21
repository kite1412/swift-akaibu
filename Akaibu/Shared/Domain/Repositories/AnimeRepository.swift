//
//  AnimeRepository.swift
//  Akaibu
//
//  Created by kite1412 on 29/12/25.
//

protocol AnimeRepository {
    func getAnimeBases(title: String, params: [String: String]?) async throws -> PaginatedResult<[AnimeBase]>
    func getAnimeRanks(limit: Int, params: [String: String]?) async throws -> PaginatedResult<[MediaRank]>
    func getAnimeSuggestions(params: [String: String]?) async throws -> PaginatedResult<[AnimeBase]>
    func getUserAnimeList(status: UserAnimeStatus?, params: [String: String]?) async throws -> PaginatedResult<[UserAnime]>
    func getAnimeDetail(withId animeId: Int) async throws -> AnimeDetail
    func getAnimeSchedules(for day: Day) async throws -> PaginatedResult<[AnimeSchedule]>
    func getAnimeGenres() async throws -> [String]
    func updateUserAnimeProgress(animeId: Int, with progress: UserAnimeProgress) async throws -> UserAnimeProgress
    func deleteUserAnimeProgress(withId animeId: Int) async throws -> Bool
}
