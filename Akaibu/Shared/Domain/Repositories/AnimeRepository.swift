//
//  AnimeRepository.swift
//  Akaibu
//
//  Created by kite1412 on 29/12/25.
//

protocol AnimeRepository {
    func getAnimeBases(title: String) async throws -> PaginatedResult<[AnimeBase]>
    func getAnimeRanks(limit: Int) async throws -> PaginatedResult<[MediaRank]>
    func getAnimeSuggestions() async throws -> PaginatedResult<[AnimeBase]>
    func getUserAnimeList(status: UserAnimeStatus?) async throws -> PaginatedResult<[UserAnime]>
}
