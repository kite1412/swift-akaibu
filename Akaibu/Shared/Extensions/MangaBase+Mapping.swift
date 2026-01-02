//
//  MangaBase+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 02/01/26.
//

extension MangaBase {
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
            status: publishingStatus.rawValue,
            scoringUsers: scoringUsers
        )
    }
}
