//
//  MALAnimeList+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 31/12/25.
//

extension MALAnimeList {
    func toAnimeBases() -> [AnimeBase] {
        data.map { anime in
            anime.toDomain()
        }
    }
}
