//
//  MALRating.swift
//  Akaibu
//
//  Created by kite1412 on 29/12/25.
//

enum MALRating: String, Codable {
    case g = "g"
    case pg = "pg"
    case pg13 = "pg_13"
    case r = "r"
    case rPlus = "r+"
    case rx = "rx"

    var description: String {
        switch self {
        case .g: return "All Ages"
        case .pg: return "Children"
        case .pg13: return "Teens 13 and Older"
        case .r: return "17+ (violence & profanity)"
        case .rPlus: return "Profanity & Mild Nudity"
        case .rx: return "Adult Content"
        }
    }
}
