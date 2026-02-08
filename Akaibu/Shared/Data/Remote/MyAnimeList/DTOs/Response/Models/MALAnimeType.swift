//
//  MALAnimeType.swift
//  Akaibu
//
//  Created by kite1412 on 29/12/25.
//

enum MALAnimeType: String, Codable {
    case unknown
    case tv
    case ova
    case movie
    case special
    case ona
    case music
    case tvSpecial = "tv_special"
    case cm
    case pv
    
    var displayName: String {
        switch self {
        case .unknown: return "Unknown"
        case .tv: return "TV"
        case .ova: return "OVA"
        case .movie: return "Movie"
        case .special: return "Special"
        case .ona: return "ONA"
        case .music: return "Music"
        case .tvSpecial: return "TV Special"
        case .cm: return "Commercial"
        case .pv: return "Promotion"
        }
    }
}
