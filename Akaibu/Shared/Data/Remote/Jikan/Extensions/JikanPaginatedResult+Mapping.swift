//
//  JikanPaginatedResult+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 21/02/26.
//

extension PaginatedResult where Item == JikanAnimeList {
    func toAnimeSchedules() -> PaginatedResult<[AnimeSchedule]> {
        let schedules = self.data.toAnimeSchedules()
        let next = next != nil ? {
            let res = try await self.next?()
            return res?.toAnimeSchedules()
        } : nil
        
        return PaginatedResult<[AnimeSchedule]>(
            data: schedules,
            next: next
        )
    }
    
    func toAnimeBases() -> PaginatedResult<[AnimeBase]> {
        let bases = self.data.toAnimeBases()
        let next = next != nil ? {
            let res = try await self.next?()
            return res?.toAnimeBases()
        } : nil
        
        return PaginatedResult<[AnimeBase]>(
            data: bases,
            next: next
        )
    }
}

extension PaginatedResult where Item == JikanMangaList {
    func toMangaBases() -> PaginatedResult<[MangaBase]> {
        mapTo(
            mapper: { mangaList in
                mangaList.data.map { manga in
                    manga.toMangaBase()
                }
            }
        )
    }
}
