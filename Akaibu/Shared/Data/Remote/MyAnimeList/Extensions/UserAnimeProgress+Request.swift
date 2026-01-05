//
//  UserAnimeProgress+Request.swift
//  Akaibu
//
//  Created by kite1412 on 05/01/26.
//

extension UserAnimeProgress {
    func toFormURLEncoded() -> [String: String] {
        [
            "status": status.toMALUserAnimeStatus().rawValue,
            "score": "\(score)",
            "num_watched_episodes": "\(totalEpisodesWatched)"
        ]
    }
}
