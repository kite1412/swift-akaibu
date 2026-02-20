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
}
