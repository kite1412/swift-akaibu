//
//  MALUserAnimeList+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 05/01/26.
//

extension MALUserAnimeList {
    func toUserAnimeList() -> [UserAnime] {
        data.map { anime in
            anime.toDomain()
        }
    }
}
