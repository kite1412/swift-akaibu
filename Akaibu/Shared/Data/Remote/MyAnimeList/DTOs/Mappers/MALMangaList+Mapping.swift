//
//  MALMangaList+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 02/01/26.
//

extension MALMangaList {
    func toMangaBases() -> [MangaBase] {
        data.map { manga in
            manga.toDomain()
        }
    }
}
