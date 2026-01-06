//
//  UserMangaProgress+Request.swift
//  Akaibu
//
//  Created by kite1412 on 07/01/26.
//

extension UserMangaProgress {
    func toFormURLEncoded() -> [String: String] {
        [
            "status": status.toMALUserMangaStatus().rawValue,
            "score": "\(score)",
            "num_chapters_read": "\(totalChaptersRead)"
        ]
    }
}
