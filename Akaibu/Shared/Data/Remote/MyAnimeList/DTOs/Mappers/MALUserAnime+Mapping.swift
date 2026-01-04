//
//  MALUserAnime+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 05/01/26.
//

extension MALUserAnime {
    func toDomain() -> UserAnime {
        UserAnime(
            id: node.id,
            title: node.title,
            synopsis: node.synopsis,
            coverImageUrl: node.mainPicture.mediumURL(),
            rating: node.rating.toDomain(),
            score: node.mean.map(Double.init) ?? 0,
            scoringUsers: node.numScoringUsers,
            genres: node.genres.toStrings(),
            airingStatus: node.status.toDomain(),
            type: node.mediaType.dislpayName(),
            userStatus: listStatus.status.toDomain(),
            userScore: listStatus.score,
            totalEpisodesWatched: listStatus.numEpisodesWatched,
            totalEpisodes: node.numEpisodes,
            updatedAt: DateFormatter.format(dateString: listStatus.updatedAt, with: .iso8601)
        )
    }
}
