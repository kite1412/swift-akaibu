//
//  AnimeRemoteDataSource.swift
//  Akaibu
//
//  Created by kite1412 on 30/12/25.
//

protocol AnimeRemoteDataSource {
    func fetchAnimeRanks() async throws -> [MediaRank]
}
