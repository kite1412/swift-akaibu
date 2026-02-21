//
//  MALMangaList.swift
//  Akaibu
//
//  Created by kite1412 on 02/01/26.
//

struct MALMangaList: Codable, MALPagable {
    let data: [MALMangaNode]
    let paging: MALPaging
}
