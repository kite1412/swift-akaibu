//
//  MALUserAnimeList.swift
//  Akaibu
//
//  Created by kite1412 on 05/01/26.
//

struct MALUserAnimeList: Codable, Pagable {
    let data: [MALUserAnime]
    let paging: MALPaging
}
