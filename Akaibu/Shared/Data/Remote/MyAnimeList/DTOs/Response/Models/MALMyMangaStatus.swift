//
//  MALMyMangaStatus.swift
//  Akaibu
//
//  Created by kite1412 on 31/12/25.
//

enum MALMyMangaStatus: String, Codable {
    case reading, completed, onHold = "on_hold", dropped, planToRead = "plan_to_read"
}
