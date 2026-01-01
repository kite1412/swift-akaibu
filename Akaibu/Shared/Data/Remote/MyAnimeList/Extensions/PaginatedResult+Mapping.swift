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
