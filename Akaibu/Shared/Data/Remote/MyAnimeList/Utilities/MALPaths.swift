//
//  MALPaths.swift
//  Akaibu
//
//  Created by kite1412 on 31/12/25.
//

struct MALPaths {
    private init() {}
    
    static let baseURLString = "https://api.myanimelist.net/v2/"
    
    static let anime = "anime"
    static let animeRanking = "anime/ranking"
    static let animeSuggestions = "anime/suggestions"
    static let userAnimeList = "users/@me/animelist"
    
    static let manga = "manga"
    static let mangaRanking = "manga/ranking"
    static let userMangaList = "users/@me/mangalist"
    
    static func updateAnimeListStatus(id: Int) -> String {
        "anime/\(id)/my_list_status"
    }
    
    static func updateMangaListStatus(id: Int) -> String {
        "manga/\(id)/my_list_status"
    }
    
    static func animeDetail(id: Int) -> String {
        "anime/\(id)"
    }
}
