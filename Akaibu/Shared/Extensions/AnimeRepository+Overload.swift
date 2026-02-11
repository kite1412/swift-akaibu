//
//  AnimeRepository+Overload.swift
//  Akaibu
//
//  Created by kite1412 on 11/02/26.
//

extension AnimeRepository {
    func getAnimeBases(title: String) async throws -> PaginatedResult<[AnimeBase]> {
        try await getAnimeBases(title: title, params: nil)
    }
    
    func getAnimeRanks(limit: Int) async throws -> PaginatedResult<[MediaRank]> {
        try await getAnimeRanks(limit: limit, params: nil)
    }
    func getAnimeSuggestions() async throws -> PaginatedResult<[AnimeBase]> {
        try await getAnimeSuggestions(params: nil)
    }
    func getUserAnimeList(status: UserAnimeStatus?) async throws -> PaginatedResult<[UserAnime]> {
        try await getUserAnimeList(status: status, params: nil)
    }
}
