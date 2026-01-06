//
//  UserMangaStatusMapper.swift
//  Akaibu
//
//  Created by kite1412 on 06/01/26.
//

struct UserMangaStatusMapper {
    static func status(from stringStatus: String?) -> UserMangaStatus? {
        if let stringStatus {
            switch stringStatus {
            case UserMangaStatus.completed.rawValue:
                return .completed
            case UserMangaStatus.reading.rawValue:
                return .reading
            case UserMangaStatus.planToRead.rawValue:
                return .planToRead
            case UserMangaStatus.dropped.rawValue:
                return .dropped
            case UserMangaStatus.onHold.rawValue:
                return .onHold
            default:
                return nil
            }
        } else {
            return nil
        }
    }
}
