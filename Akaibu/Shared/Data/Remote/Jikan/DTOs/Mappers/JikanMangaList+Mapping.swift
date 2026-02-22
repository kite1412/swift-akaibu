//
//  JikanMangaList+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 22/02/26.
//

extension JikanMangaList {
    func toMangaBases() -> [MangaBase] {
        data.map { manga in
            manga.toMangaBase()
        }
    }
}
