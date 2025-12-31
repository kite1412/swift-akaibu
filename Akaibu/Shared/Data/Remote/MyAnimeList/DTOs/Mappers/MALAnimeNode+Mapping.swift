//
//  MALAnimeNode+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 31/12/25.
//

import Foundation

extension MALAnimeNode {
    func toDomain() -> AnimeBase {
        let anime = self.node
        
        return AnimeBase(
            id: anime.id,
            title: anime.title,
            synopsis: anime.synopsis,
            type: anime.mediaType.dislpayName(),
            coverImageURL: anime.mainPicture.mediumURL(),
            rating: anime.rating.toDomain(),
            airingStatus: anime.status.toDomain(),
            genres: anime.genres.toStrings(),
            score: node.mean.map(Double.init),
            scoringUsers: node.numScoringUsers
        )
    }
}
