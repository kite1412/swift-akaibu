//
//  JikanPaginatedResult+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 21/02/26.
//

extension PaginatedResult where Item == JikanAnimeList {
    func toAnimeSchedules() -> PaginatedResult<[AnimeSchedule]> {
        let schedules = self.data.toAnimeSchedules()
        
        return PaginatedResult<[AnimeSchedule]>(
            data: schedules,
            next: {
                let res = try await self.next?()
                return res?.toAnimeSchedules()
            }
        )
    }
}
