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
    static let rank = "[mean,synopsis,media_type,status,nsfw,num_scoring_users,genres]"
    static let userManga = "[synopsis,media_type,nsfw,status,genres,mean,num_scoring_users,num_chapters,list_status]"
    static let detail = "[synopsis,media_type,nsfw,status,genres,mean,num_scoring_users,num_chapters,my_list_status,"
        + "num_volumes,rank,alternative_titles,start_date,end_date,authors,related_manga,recommendations]"
}
