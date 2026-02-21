//
//  MediaRank+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 22/02/26.
//

extension MediaRank {
    func toMediaCardData() -> MediaCardData {
        MediaCardData(
            id: id,
            title: title,
            synopsis: synopsis,
            coverImageURL: coverImageURL,
            isAdult: isAdult,
            genres: genres,
            score: score,
            type: type,
            status: status,
            scoringUsers: scoringUsers
        )
    }
}
