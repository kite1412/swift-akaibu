//
//  JikanAnime+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 20/02/26.
//

import Foundation

extension JikanAnime {
    func toAnimeSchedule() -> AnimeSchedule? {
        if let dayString = broadcast.day?.lowercased().dropLast(), let time = broadcast.time {
            if let day = Day(rawValue: String(dayString)) {
                let (day, time) = dayTimeLocalized(
                    day: day,
                    time: time,
                    from: TimeZone(identifier: "Asia/Tokyo")!
                )
                
                return AnimeSchedule(
                    id: malId,
                    title: title,
                    synopsis: synopsis,
                    type: type ?? "Unknown",
                    coverImageURL: images.jpgURL(),
                    rating: explicitGenres.isEmpty ? .safe : .adult,
                    airingStatus: .airing,
                    genres: genres.map(\.name),
                    score: score,
                    scoringUsers: scoredBy,
                    day: day,
                    time: time
                )
            }
        }
        
        return nil
    }
}
