//
//  MALRelatedAnime+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 14/02/26.
//

extension MALRelatedAnime {
    func toDomain() -> RelatedMedia {
        RelatedMedia(
            id: node.id,
            title: node.title,
            coverImageURL: node.mainPicture.mediumURL(),
            relationType: relationTypeFormatted
        )
    }
}
