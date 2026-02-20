//
//  AnimeSchedule+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 20/02/26.
//

import Foundation

extension AnimeSchedule {
    func toSmallMediaCardData() -> SmallMediaCardData {
        SmallMediaCardData(
            id: id,
            title: title,
            coverImageURL: coverImageURL,
            description: "\(day.rawValue.capitalized) \(time)"
        )
    }
    
    func toMediaCardData() -> MediaCardData {
        MediaCardData(
            id: id,
            title: title,
            synopsis: synopsis,
            coverImageURL: coverImageURL,
            isAdult: rating.isAdult,
            genres: genres,
            score: score,
            type: type,
            status: airingStatus.rawValue,
            scoringUsers: scoringUsers
        )
    }
}
