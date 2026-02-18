//
//  RelatedMedia+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 19/02/26.
//

extension RelatedMedia {
    func toSmallMediaCardData(description: String? = nil) -> SmallMediaCardData {
        SmallMediaCardData(
            id: id,
            title: title,
            coverImageURL: coverImageURL,
            description: description
        )
    }
}
