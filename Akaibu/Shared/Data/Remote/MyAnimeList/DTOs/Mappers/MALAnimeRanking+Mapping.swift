//
//  MALAnimeRanking+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 30/12/25.
//

extension MALAnimeRanking {
    func toMediaRanks() -> [MediaRank] {
        data.map { anime in
            anime.toDomain()
        }
    }
}
