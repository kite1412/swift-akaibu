//
//  JikanAnimeList+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 20/02/26.
//

extension JikanAnimeList {
    func toAnimeBases() -> [AnimeBase] {
        data.map { anime in
            anime.toDomain()
        }
    }
}
