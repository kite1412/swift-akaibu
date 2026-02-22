//
//  MALPaginatedResult+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 01/01/26.
//

extension PaginatedResult where Item == MALAnimeList {
    func toDomain() -> PaginatedResult<[AnimeBase]> {
        mapTo { model in
            model.toAnimeBases()
        }
    }
}

extension PaginatedResult where Item == MALAnimeRanking {
    func toDomain() -> PaginatedResult<[MediaRank]> {
        mapTo { model in
            model.toMediaRanks()
        }
    }
}

extension PaginatedResult where Item == MALMangaRanking {
    func toDomain() -> PaginatedResult<[MediaRank]> {
        mapTo { model in
            model.toMediaRanks()
        }
    }
}

extension PaginatedResult where Item == MALMangaList {
    func toDomain() -> PaginatedResult<[MangaBase]> {
        mapTo { model in
            model.toMangaBases()
        }
    }
}

extension PaginatedResult where Item == MALUserAnimeList {
    func toDomain() -> PaginatedResult<[UserAnime]> {
        mapTo { model in
            model.toUserAnimeList()
        }
    }
}

extension PaginatedResult where Item == MALUserMangaList {
    func toDomain() -> PaginatedResult<[UserManga]> {
        mapTo { model in
            model.toUserMangaList()
        }
    }
}
