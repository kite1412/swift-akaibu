//
//  JikanAnimeList.swift
//  Akaibu
//
//  Created by kite1412 on 20/02/26.
//

struct JikanAnimeList: Codable, JikanPagable {
    let data: [JikanAnime]
    let pagination: JikanPagination
}
