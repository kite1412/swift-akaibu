//
//  MALUserMangaListStatus+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 07/01/26.
//

extension MALUserMangaListStatus {
    func toDomain() -> UserMangaProgress {
        UserMangaProgress(
            status: status.toDomain(),
            score: score,
            totalChaptersRead: numChaptersRead,
            updatedAt: DateFormatter.format(dateString: updatedAt, with: .iso8601)
        )
    }
}
