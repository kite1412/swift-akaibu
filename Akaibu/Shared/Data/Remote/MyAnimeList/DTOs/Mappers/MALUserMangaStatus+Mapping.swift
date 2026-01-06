//
//  MALUserMangaStatus+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 06/01/26.
//

extension MALUserMangaStatus {
    func toDomain() -> UserMangaStatus {
        switch self {
        case .completed: return .completed
        case .reading: return .reading
        case .planToRead: return .planToRead
        case .dropped: return .dropped
        case .onHold: return .onHold
        }
    }
}
