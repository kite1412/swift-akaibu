//
//  UserAnimeStatusMapper.swift
//  Akaibu
//
//  Created by kite1412 on 05/01/26.
//

struct UserAnimeStatusMapper {
    private init() {}
    
    static func status(from stringStatus: String?) -> UserAnimeStatus? {
        if let stringStatus {
            switch stringStatus {
            case UserAnimeStatus.watching.rawValue:
                return .watching
            case UserAnimeStatus.completed.rawValue:
                return .completed
            case UserAnimeStatus.planToWatch.rawValue:
                return .planToWatch
            case UserAnimeStatus.dropped.rawValue:
                return .dropped
            case UserAnimeStatus.onHold.rawValue:
                return .onHold
            default:
                return nil
            }
        } else {
            return nil
        }
    }
    
    static func string(from status: UserAnimeStatus?) -> String? {
        status?.rawValue
    }
}
