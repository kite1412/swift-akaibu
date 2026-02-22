//
//  JikanPaginatedResult+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 21/02/26.
//

extension PaginatedResult where Item == JikanAnimeList {
    func toAnimeSchedules() -> PaginatedResult<[AnimeSchedule]> {
        mapTo { model in
            model.toAnimeSchedules()
        }
    }
    
    func toAnimeBases() -> PaginatedResult<[AnimeBase]> {
        mapTo { model in
            model.toAnimeBases()
        }
    }
}

extension PaginatedResult where Item == JikanMangaList {
    func toMangaBases() -> PaginatedResult<[MangaBase]> {
        mapTo { model in
            model.toMangaBases()
        }
    }
}
