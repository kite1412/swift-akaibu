//
//  MangaDetail+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 18/02/26.
//

extension MangaDetail {
    func toMediaDetailData() -> MediaDetailData {
        MediaDetailData(
            title: title,
            synopsis: synopsis,
            coverImageURL: coverImageURL,
            type: type,
            status: publishingStatus.rawValue,
            isAdult: isAdult,
            genres: genres,
            score: score,
            scoringUsers: scoringUsers,
            alternativeTitles: alternativeTitles,
            rank: rank,
            totalUnits: totalChapters,
            userProgress: userProgress?.toUserMediaProgress(),
            relatedMedia: relatedManga,
            recommendations: recommendations
        )
    }
}
