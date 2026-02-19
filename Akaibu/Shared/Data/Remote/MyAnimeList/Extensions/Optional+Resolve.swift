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

extension Optional where Wrapped == MALAlternativeTitles {
    func toStrings() -> [String] {
        self?.toStrings() ?? []
    }
}

extension Optional where Wrapped == MALStartSeason {
    func toString() -> String? {
        if let self {
            return "\(self.season.rawValue.capitalized) \(self.year)"
        } else {
            return nil
        }
    }
}

extension Optional where Wrapped == MALBroadcast {
    var localizedDateString: String? {
        guard let startTime = self?.startTime else { return nil }
        guard let dayOfTheWeek = self?.dayOfTheWeek else { return nil }
        
        let formatter = Foundation.DateFormatter()
        formatter.dateFormat = "EEEE HH:mm"
        formatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        
        guard let date = formatter.date(from: "\(dayOfTheWeek) \(startTime)") else { return nil }
        
        formatter.timeZone = .current
        
        return formatter.string(from: date)
    }
}

extension Optional where Wrapped == Array<MALStudio> {
    func toStrings() -> [String] {
        if let self {
            return self.map(\.name)
        } else {
            return []
        }
    }
}

extension Optional where Wrapped == Array<MALRelatedAnime> {
    func toDomain() -> [RelatedMedia] {
        if let self {
            return self.map { related in
                related.toDomain()
            }
        } else {
            return []
        }
    }
}

extension Optional where Wrapped == Array<MALAnimeRecommendation> {
    func toDomain() -> [MediaRecommendation] {
        if let self {
            return self.map { manga in
                manga.toDomain()
            }
        } else {
            return []
        }
    }
}

extension Optional where Wrapped == Array<MALAuthor> {
    func toDomain() -> [Author] {
        if let self {
            return self.map { author in
                author.toDomain()
            }
            .compactMap { $0 }
        } else {
            return []
        }
    }
}

extension Optional where Wrapped == Array<MALRelatedManga> {
    func toDomain() -> [RelatedMedia] {
        if let self {
            return self.map { manga in
                manga.toDomain()
            }
        } else {
            return []
        }
    }
}

extension Optional where Wrapped == Array<MALMangaRecommendation> {
    func toDomain() -> [MediaRecommendation] {
        if let self {
            return self.map { manga in
                manga.toDomain()
            }
        } else {
            return []
        }
    }
}
