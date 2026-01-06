//
//  PaginatedResult+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 01/01/26.
//

extension PaginatedResult where Item == MALAnimeList {
    func toDomain() -> PaginatedResult<[AnimeBase]> {
        let animeBases = self.data.toAnimeBases()
        return PaginatedResult<[AnimeBase]>(
            data: animeBases,
            next: {
                let res = try await self.next?()
                return res?.toDomain()
            }
        )
    }
}

extension PaginatedResult where Item == MALAnimeRanking {
    func toDomain() -> PaginatedResult<[MediaRank]> {
        let mediaRanks = self.data.toMediaRanks()
        return PaginatedResult<[MediaRank]>(
            data: mediaRanks,
            next: {
                let res = try await self.next?()
                return res?.toDomain()
            }
        )
    }
}

extension PaginatedResult where Item == MALMangaRanking {
    func toDomain() -> PaginatedResult<[MediaRank]> {
        let mediaRanks = self.data.toMediaRanks()
        return PaginatedResult<[MediaRank]>(
            data: mediaRanks,
            next: {
                let res = try await self.next?()
                return res?.toDomain()
            }
        )
    }
}

extension PaginatedResult where Item == MALMangaList {
    func toDomain() -> PaginatedResult<[MangaBase]> {
        let mangaBases = self.data.toMangaBases()
        return PaginatedResult<[MangaBase]>(
            data: mangaBases,
            next: {
                let res = try await self.next?()
                return res?.toDomain()
            }
        )
    }
}

extension PaginatedResult where Item == MALUserAnimeList {
    func toDomain() -> PaginatedResult<[UserAnime]> {
        let userAnimeList = self.data.toUserAnimeList()
        return PaginatedResult<[UserAnime]>(
            data: userAnimeList,
            next: {
                let res = try await self.next?()
                return res?.toDomain()
            }
        )
    }
}

extension PaginatedResult where Item == MALUserMangaList {
    func toDomain() -> PaginatedResult<[UserManga]> {
        let userMangaList = self.data.toUserMangaList()
        return PaginatedResult<[UserManga]>(
            data: userMangaList,
            next: {
                let res = try await self.next?()
                return res?.toDomain()
            }
        )
    }
}
