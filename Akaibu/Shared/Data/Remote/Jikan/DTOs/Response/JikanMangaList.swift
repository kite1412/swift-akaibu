//
//  JikanMangaList.swift
//  Akaibu
//
//  Created by kite1412 on 22/02/26.
//

struct JikanMangaList: Codable, JikanPagable {
    let data: [JikanManga]
    let pagination: JikanPagination
}
