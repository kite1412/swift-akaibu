//
//  JikanAnime+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 20/02/26.
//

extension JikanAnime {
    // TODO localized .day and .time
    func toAnimeSchedule() -> AnimeSchedule {
        AnimeSchedule(
            id: malId,
            title: title,
            coverImageURL: images.jpgURL(),
            day: Day(rawValue: String(broadcast.day!.lowercased().dropLast()))!,
            time: broadcast.time!
        )
    }
}
