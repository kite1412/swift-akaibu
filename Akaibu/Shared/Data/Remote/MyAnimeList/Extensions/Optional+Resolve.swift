//
//  Optional+Resolve.swift
//  Akaibu
//
//  Created by kite1412 on 31/12/25.
//

import Foundation

extension Optional where Wrapped == MALAnimeType {
    func dislpayName() -> String {
        self?.displayName ?? MALAnimeType.unknown.displayName
    }
}

extension Optional where Wrapped == MALPicture {
    func mediumURL() -> URL? {
        self.flatMap { p in
            URL(string: p.medium)
        }
    }
    
    func largeURLFirst() -> URL? {
        self.flatMap { p in
            URL(string: p.large ?? p.medium)
        }
    }
}

extension Optional where Wrapped == MALRating {
    func toDomain() -> Rating {
        if let self {
            return self.toDomain()
        } else {
            return .safe
        }
    }
}

extension Optional where Wrapped == MALAnimeStatus {
    func toDomain() -> AiringStatus {
        self?.toDomain() ?? .notYetAired
    }
}

extension Optional where Wrapped == Array<MALGenre> {
    func toStrings() -> [String] {
        self?.map(\.name) ?? []
    }
}

extension Optional where Wrapped == MALMangaType {
    func dislpayName() -> String {
        self?.displayName ?? MALMangaType.unknown.displayName
    }
}

extension Optional where Wrapped == MALMangaStatus {
    func toDomain() -> PublishingStatus {
        self?.toDomain() ?? .notYetPublished
    }
}
