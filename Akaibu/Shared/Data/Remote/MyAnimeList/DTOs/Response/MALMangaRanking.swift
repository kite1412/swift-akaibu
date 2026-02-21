//
//  MALMangaRanking.swift
//  Akaibu
//
//  Created by kite1412 on 31/12/25.
//

struct MALMangaRanking: Codable, MALPagable {
    let data: [MALMangaRank]
    let paging: MALPaging
}
