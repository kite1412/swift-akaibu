//
//  MALMangaFields.swift
//  Akaibu
//
//  Created by kite1412 on 31/12/25.
//

/// A utility to resolve the 'fields' needed for each Manga model defined in Domain
struct MALMangaFields {
    private init() {}
    
    static let base = "[synopsis,media_type,nsfw,status,genres,mean,num_scoring_users]"
    static let rank = "[mean,synopsis,media_type,status,rating,nsfw]"
}
