//
//  AnimeDetail+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 17/02/26.
//

extension AnimeDetail {
    func toMediaDetailData() -> MediaDetailData {
        MediaDetailData(
            title: title,
            synopsis: synopsis,
            coverImageURL: coverImageURL,
            type: type,
            status: airingStatus.rawValue,
            isAdult: rating.isAdult,
            genres: genres,
            score: score,
            scoringUsers: scoringUsers,
            alternativeTitles: alternativeTitles,
            rank: rank,
            totalUnits: totalEpisodes,
            userProgress: userProgress?.toUserMediaProgress(),
            relatedMedia: relatedAnime,
            recommendations: recommendations,
            characters: characters
        )
    }
}
