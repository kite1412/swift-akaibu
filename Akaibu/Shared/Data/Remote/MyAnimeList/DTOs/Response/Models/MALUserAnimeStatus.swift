//
//  MALUserAnimeStatus.swift
//  Akaibu
//
//  Created by kite1412 on 29/12/25.
//

enum MALUserAnimeStatus: String, Codable {
    case watching, completed, planToWatch = "plan_to_watch", dropped, onHold = "on_hold"
}
