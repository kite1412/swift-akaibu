//
//  MALMangaStatus+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 31/12/25.
//

extension MALMangaStatus {
    func toDomain() -> PublishingStatus {
        switch self {
        case .currentlyPublishing: return .publishing
        case .finished: return .finished
        case .notYetPublished: return .notYetPublished
        case .onHiatus: return .hiatus
        }
    }
}
