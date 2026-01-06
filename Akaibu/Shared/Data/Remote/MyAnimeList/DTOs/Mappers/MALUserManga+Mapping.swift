//
//  MALUserManga+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 06/01/26.
//

import Foundation

extension MALUserManga {
    func toDomain() -> UserManga {
        UserManga(
            id: node.id,
            title: node.title,
            synopsis: node.synopsis,
            coverImageUrl: node.mainPicture.mediumURL(),
            isAdult: node.nsfw?.isDangerous ?? false,
            score: node.mean.map(Double.init),
            scoringUsers: node.numScoringUsers,
            genres: node.genres.toStrings(),
            publishingStatus: node.status.toDomain(),
            type: node.mediaType.dislpayName(),
            totalChapters: node.numChapters,
            progress: UserMangaProgress(
                status: listStatus.status.toDomain(),
                score: listStatus.score,
                totalChaptersRead: listStatus.numChaptersRead,
                updatedAt: DateFormatter.format(dateString: listStatus.updatedAt, with: .iso8601)
            )
        )
    }
}
