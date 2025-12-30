//
//  MALAnimeStatus+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 31/12/25.
//

extension MALAnimeStatus {
    func toDomain() -> AiringStatus {
        switch self {
        case .currentlyAiring: return .airing
        case .finishedAiring: return .completed
        case .notYetAired: return .notYetAired
        }
    }
}
