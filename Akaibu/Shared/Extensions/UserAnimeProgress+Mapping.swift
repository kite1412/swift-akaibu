//
//  UserAnimeProgress+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 17/02/26.
//

extension UserAnimeProgress {
    func toUserMediaProgress() -> UserMediaProgress {
        UserMediaProgress(
            status: status.rawValue,
            score: score,
            consumedUnits: totalEpisodesWatched,
            updatedAt: updatedAt
        )
    }
}
