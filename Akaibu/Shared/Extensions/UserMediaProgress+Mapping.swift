//
//  UserMediaProgress+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 19/02/26.
//

extension UserMediaProgress {
    func toUserAnimeProgress() -> UserAnimeProgress {
        UserAnimeProgress(
            status: UserAnimeStatus(rawValue: status)!,
            score: score,
            totalEpisodesWatched: consumedUnits,
            updatedAt: updatedAt
        )
    }
    
    func toUserMangaProgress() -> UserMangaProgress {
        UserMangaProgress(
            status: UserMangaStatus(rawValue: status)!,
            score: score,
            totalChaptersRead: consumedUnits,
            updatedAt: updatedAt
        )
    }
}
