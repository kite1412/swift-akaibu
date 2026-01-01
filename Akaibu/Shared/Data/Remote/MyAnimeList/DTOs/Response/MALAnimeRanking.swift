//
//  MALAnimeRanking.swift
//  Akaibu
//
//  Created by kite1412 on 30/12/25.
//

struct MALAnimeRanking: Codable & Pagable {
    let data: [MALAnimeRank]
    let paging: MALPaging
}
