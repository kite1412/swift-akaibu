//
//  UserMediaData+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 03/01/26.
//

extension UserMediaData {
    func toMediaCardData() -> MediaCardData {
        MediaCardData(
            id: id,
            title: title,
            synopsis: synopsis,
            coverImageURL: coverImageUrl,
            isAdult: isAdult,
            genres: genres,
            score: score,
            type: type,
            status: status,
            scoringUsers: scoringUsers
        )
    }
}
