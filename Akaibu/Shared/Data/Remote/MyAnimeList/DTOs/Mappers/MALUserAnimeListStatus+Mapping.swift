//
//  MALUserAnimeListStatus+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 05/01/26.
//

extension MALUserAnimeListStatus {
    func toDomain() -> UserAnimeProgress {
        UserAnimeProgress(
            status: status.toDomain(),
            score: score,
            totalEpisodesWatched: numEpisodesWatched,
            updatedAt: DateFormatter.format(dateString: updatedAt, with: .iso8601)
        )
    }
}
