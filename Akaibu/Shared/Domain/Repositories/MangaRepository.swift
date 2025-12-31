//
//  MangaRepository.swift
//  Akaibu
//
//  Created by kite1412 on 31/12/25.
//

protocol MangaRepository {
    func getMangaRanks() async throws -> [MediaRank]
}
