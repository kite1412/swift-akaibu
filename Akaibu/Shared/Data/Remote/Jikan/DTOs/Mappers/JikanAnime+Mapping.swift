//
//  JikanAnime+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 20/02/26.
//

import Foundation

extension JikanAnime {
    func toAnimeSchedule() -> AnimeSchedule {
        let (day, time) = dayTimeLocalized(
            day: Day(rawValue: String(broadcast.day!.lowercased().dropLast()))!,
            time: broadcast.time!,
            from: TimeZone(identifier: "Asia/Tokyo")!
        )
        
        return AnimeSchedule(
            id: malId,
            title: title,
            coverImageURL: images.jpgURL(),
            day: day,
            time: time
        )
    }
}
