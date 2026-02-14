//
//  MALAnimeFields.swift
//  Akaibu
//
//  Created by kite1412 on 31/12/25.
//

/// A utility to resolve the 'fields' needed for each Anime model defined in Domain
struct MALAnimeFields {
    private init() {}
    
    static let base = "[synopsis,media_type,rating,status,genres,mean,num_scoring_users]"
    static let rank = "[mean,synopsis,media_type,status,rating]"
    static let userAnime = "[synopsis,media_type,rating,status,genres,mean,num_scoring_users,num_episodes,list_status]"
    static let detail = "[synopsis,media_type,rating,status,genres,mean,num_scoring_users,"
        + "num_episodes,my_list_status,rank,alternative_titles,"
        + "broadcast,average_episode_duration,studios,related_anime]"
}
