//
//  MangaRemoteDataSource.swift
//  Akaibu
//
//  Created by kite1412 on 31/12/25.
//

protocol MangaRemoteDataSource {
    func fetchMangaRanks() async throws -> [MediaRank]
}
