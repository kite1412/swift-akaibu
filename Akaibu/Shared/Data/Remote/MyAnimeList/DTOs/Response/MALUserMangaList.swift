//
//  MALUserMangaList.swift
//  Akaibu
//
//  Created by kite1412 on 06/01/26.
//

struct MALUserMangaList: Codable, MALPagable {
    let data: [MALUserManga]
    let paging: MALPaging
}
