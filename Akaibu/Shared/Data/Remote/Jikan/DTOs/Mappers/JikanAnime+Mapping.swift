//
//  JikanAnime+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 20/02/26.
//

extension JikanAnime {
    func toDomain() -> AnimeBase {
        AnimeBase(
            id: malId,
            title: title,
            synopsis: synopsis,
            type: type ?? "Unknown",
            coverImageURL: images.jpgURL(),
            rating: .safe, // ignored
            airingStatus: .airing,
            genres: genres.map(\.name),
            score: score,
            scoringUsers: scoredBy
        )
    }
}
