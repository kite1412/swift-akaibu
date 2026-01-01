//
//  AnimeBase+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 01/01/26.
//

extension AnimeBase {
    func toMediaSliderData() -> MediaSliderData {
        MediaSliderData(
            id: id,
            title: title,
            synopsis: synopsis,
            coverImageUrl: coverImageURL,
            score: score,
            scoringUsers: scoringUsers,
            isAdult: rating.isAdult,
            genres: genres,
            status: airingStatus.rawValue
        )
    }
}
