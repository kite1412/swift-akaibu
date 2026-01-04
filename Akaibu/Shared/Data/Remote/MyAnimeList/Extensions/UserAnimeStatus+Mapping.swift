//
//  UserAnimeStatus+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 05/01/26.
//

extension UserAnimeStatus {
    func toMALUserAnimeStatus() -> MALUserAnimeStatus {
        switch self {
        case .watching: return .watching
        case .completed: return .completed
        case .onHold: return .onHold
        case .dropped: return .dropped
        case .planToWatch: return .planToWatch
        }
    }
}
