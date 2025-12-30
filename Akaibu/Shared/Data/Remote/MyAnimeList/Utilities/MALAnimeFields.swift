//
//  MALAnimeFields.swift
//  Akaibu
//
//  Created by kite1412 on 31/12/25.
//

/// A utility to resolve the 'fields' needed for each Anime model defined in Domain
struct MALAnimeFields {
    private init() {}
    
    static let base = "[synopsis,type,rating,status,genres,mean,num_scoring_users]"
    static let rank = "[mean,synopsis,media_type,status,rating]"
}
