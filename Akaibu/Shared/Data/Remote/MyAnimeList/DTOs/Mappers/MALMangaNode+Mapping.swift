//
//  MALMangaNode+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 02/01/26.
//

import Foundation

extension MALMangaNode {
    func toDomain() -> MangaBase {
        MangaBase(
            id: node.id,
            title: node.title,
            synopsis: node.synopsis,
            type: node.mediaType.dislpayName(),
            coverImageURL: node.mainPicture.mediumURL(),
            isAdult: node.nsfw?.isDangerous ?? false,
            publishingStatus: node.status.toDomain(),
            genres: node.genres.toStrings(),
            score: node.mean.map(Double.init),
            scoringUsers: node.numListUsers
        )
    }
}
