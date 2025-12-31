//
//  MALMangaRanking+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 31/12/25.
//

extension MALMangaRanking {
    func toMediaRanks() -> [MediaRank] {
        data.map { manga in
            manga.toDomain()
        }
    }
}
