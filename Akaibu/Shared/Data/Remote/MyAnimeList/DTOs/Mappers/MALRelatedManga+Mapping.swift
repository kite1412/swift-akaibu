//
//  MALRelatedManga+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 18/02/26.
//

extension MALRelatedManga {
    func toDomain() -> RelatedMedia {
        RelatedMedia(
            id: node.id,
            title: node.title,
            coverImageURL: node.mainPicture.mediumURL(),
            relationType: relationType
        )
    }
}
