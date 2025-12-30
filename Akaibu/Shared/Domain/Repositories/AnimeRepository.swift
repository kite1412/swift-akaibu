//
//  AnimeRepository.swift
//  Akaibu
//
//  Created by kite1412 on 29/12/25.
//

protocol AnimeRepository {
    func getAnimeBases() async throws -> [AnimeBase]
    func getAnimeRanks() async throws -> [MediaRank]
}
