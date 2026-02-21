//
//  MALAnimeRanking.swift
//  Akaibu
//
//  Created by kite1412 on 30/12/25.
//

struct MALAnimeRanking: Codable & MALPagable {
    let data: [MALAnimeRank]
    let paging: MALPaging
}
