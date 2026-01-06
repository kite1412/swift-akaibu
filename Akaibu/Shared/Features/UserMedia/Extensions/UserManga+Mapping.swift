//
//  UserManga+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 06/01/26.
//

extension UserManga {
    func toUserMediaData() -> UserMediaData {
        UserMediaData(
            id: id,
            title: title,
            synopsis: synopsis,
            coverImageUrl: coverImageUrl,
            isAdult: isAdult,
            score: score,
            scoringUsers: scoringUsers,
            genres: genres,
            status: publishingStatus.rawValue,
            type: type,
            totalUnits: totalChapters,
            userStatus: progress.status.rawValue,
            userScore: progress.score,
            consumedUnits: progress.totalChaptersRead,
            updatedAt: progress.updatedAt
        )
    }
}
