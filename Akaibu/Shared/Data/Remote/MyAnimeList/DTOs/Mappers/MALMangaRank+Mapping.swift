//
//  MALMangaRank+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 31/12/25.
//

extension MALMangaRank {
    func toDomain() -> MediaRank {
        MediaRank(
            id: node.id,
            title: node.title,
            synopsis: node.synopsis,
            rank: ranking.rank,
            type: node.mediaType.dislpayName(),
            status: node.status.toDomain().rawValue,
            coverImageURL: node.mainPicture.mediumURL(),
            isAdult: node.nsfw?.isDangerous ?? false,
            score: node.mean.map(Double.init) ?? 0
        )
    }
}
