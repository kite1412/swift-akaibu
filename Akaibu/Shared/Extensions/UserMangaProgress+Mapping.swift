//
//  UserMangaProgress+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 18/02/26.
//

extension UserMangaProgress {
    func toUserMediaProgress() -> UserMediaProgress {
        UserMediaProgress(
            status: status.rawValue,
            score: score,
            consumedUnits: totalChaptersRead,
            updatedAt: updatedAt
        )
    }
}
