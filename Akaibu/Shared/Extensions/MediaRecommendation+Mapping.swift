//
//  MediaRecommendation+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 18/02/26.
//

extension MediaRecommendation {
    func toSmallMediaCardData(description: String? = nil) -> SmallMediaCardData {
        SmallMediaCardData(
            id: id,
            title: title,
            coverImageURL: coverImageURL,
            description: description
        )
    }
}
