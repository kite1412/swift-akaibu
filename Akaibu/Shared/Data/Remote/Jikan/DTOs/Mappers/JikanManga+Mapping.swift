//
//  JikanManga+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 22/02/26.
//

extension JikanManga {
    func toMangaBase() -> MangaBase {
        MangaBase(
            id: malId,
            title: title,
            synopsis: synopsis,
            type: type ?? "Unknown",
            coverImageURL: images.jpgURL(),
            isAdult: !explicitGenres.isEmpty,
            publishingStatus: status?.toDomain() ?? .notYetPublished,
            genres: genres.map(\.name),
            score: score,
            scoringUsers: scoredBy
        )
    }
}
