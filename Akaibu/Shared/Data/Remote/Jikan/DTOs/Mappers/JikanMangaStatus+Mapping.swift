//
//  JikanMangaStatus+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 22/02/26.
//

extension JikanMangaStatus {
    func toDomain() -> PublishingStatus {
        switch self {
        case .publishing: return .publishing
        case .finished: return .finished
        case .onHiatus: return .hiatus
        default: return .notYetPublished
        }
    }
}
