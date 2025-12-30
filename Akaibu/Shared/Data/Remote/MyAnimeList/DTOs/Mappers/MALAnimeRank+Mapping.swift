//
//  MALAnimeRank+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 30/12/25.
//

import Foundation

extension MALAnimeRank {
    func toDomain() -> MediaRank {
        MediaRank(
            id: node.id,
            title: node.title,
            description: node.synopsis,
            rank: ranking.rank,
            type: node.mediaType?.displayName ?? MALAnimeType.unknown.displayName,
            status: node.status?.displayName ?? "Unknown",
            coverImageURL: node.mainPicture != nil ? URL.init(string: node.mainPicture!.medium) : nil,
            isAdult: node.rating.map(\.isAdult) ?? false,
            score: node.mean.map(Double.init) ?? 0
        )
    }
}
