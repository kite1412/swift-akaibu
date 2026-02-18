//
//  MALAnimeRecommendationl+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 18/02/26.
//

extension MALAnimeRecommendation {
    func toDomain() -> MediaRecommendation {
        MediaRecommendation(
            id: node.id,
            title: node.title,
            coverImageURL: node.mainPicture.mediumURL(),
            totalVotes: numRecommendations
        )
    }
}
