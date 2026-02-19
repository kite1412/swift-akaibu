//
//  AnimeSchedule+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 20/02/26.
//

extension AnimeSchedule {
    func toSmallMediaCardData() -> SmallMediaCardData {
        SmallMediaCardData(
            id: id,
            title: title,
            coverImageURL: coverImageURL,
            description: time
        )
    }
}
