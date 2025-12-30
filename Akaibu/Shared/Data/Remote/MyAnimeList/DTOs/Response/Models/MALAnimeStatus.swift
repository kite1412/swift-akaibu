//
//  MALAnimeStatus.swift
//  Akaibu
//
//  Created by kite1412 on 29/12/25.
//

enum MALAnimeStatus: String, Codable {
    case finishedAiring = "finished_airing"
    case currentlyAiring = "currently_airing"
    case notYetAired = "not_yet_aired"
    
    var displayName: String {
        switch self {
        case .finishedAiring: return "Completed"
        case .currentlyAiring: return "Airing"
        case .notYetAired: return "Not yet aired"
        }
    }
}
