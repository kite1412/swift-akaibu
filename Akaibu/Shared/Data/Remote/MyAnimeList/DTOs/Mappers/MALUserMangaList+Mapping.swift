//
//  MALUserMangaList+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 06/01/26.
//

extension MALUserMangaList {
    func toUserMangaList() -> [UserManga] {
        data.map { manga in
            manga.toDomain()
        }
    }
}
