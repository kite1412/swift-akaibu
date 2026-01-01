//
//  MALAnimeList.swift
//  Akaibu
//
//  Created by kite1412 on 31/12/25.
//

struct MALAnimeList: Codable, Pagable {
    let data: [MALAnimeNode]
    let paging: MALPaging
}
