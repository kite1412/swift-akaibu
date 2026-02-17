//
//  UserAnime+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 05/01/26.
//

extension UserAnime {
    func toUserMediaData() -> UserMediaData {
        UserMediaData(
            id: id,
            title: title,
            synopsis: synopsis,
            coverImageUrl: coverImageUrl,
            isAdult: rating.isAdult,
            score: score,
            scoringUsers: scoringUsers,
            genres: genres,
            status: airingStatus.rawValue,
            type: type,
            totalUnits: totalEpisodes ?? 0,
            userMediaProgress: UserMediaProgress(
                status: progress.status.rawValue,
                score: progress.score,
                consumedUnits: progress.totalEpisodesWatched,
                updatedAt: progress.updatedAt
            )
        )
    }
}
