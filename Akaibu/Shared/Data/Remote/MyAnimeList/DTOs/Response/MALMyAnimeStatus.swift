//
//  MALMyAnimeStatus.swift
//  Akaibu
//
//  Created by kite1412 on 29/12/25.
//

enum MALMyAnimeStatus: String, Codable {
    case watching
    case completed
    case planToWatch = "plan_to_watch"
    case dropped
    case onHold = "on_hold"
}
