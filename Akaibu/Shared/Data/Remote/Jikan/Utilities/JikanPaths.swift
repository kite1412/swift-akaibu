//
//  JikanPaths.swift
//  Akaibu
//
//  Created by kite1412 on 20/02/26.
//

struct JikanPaths {
    private init() {}
    
    static let baseURLString = "https://api.jikan.moe/v4/"
    
    static let anime = "anime"
    static let animeGenres = "genres/anime"
    static let animeSchedules = "schedules"
    
    static let manga = "manga"
    static let mangaGenres = "genres/manga"
    
    static func animeCharacters(animeId: Int) -> String {
        "\(anime)/\(animeId)/characters"
    }
    
    static func mangaCharacters(mangaId: Int) -> String {
        "\(manga)/\(mangaId)/characters"
    }
}
