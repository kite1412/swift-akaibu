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
    static let animeGenres = "anime/genres"
    
    static let manga = "manga"
    static let mangaGenres = "manga/genres"
    
    static func animeCharacters(animeId: Int) -> String {
        "\(anime)/\(animeId)/characters"
    }
    
    static func animeSchedules(_ day: Day? = nil) -> String {
        let filter = if let day {
            "?filter=\(day.rawValue)"
        } else {
            ""
        }
        
        return "schedules\(filter)"
    }
    
    static func mangaCharacters(mangaId: Int) -> String {
        "\(manga)/\(mangaId)/characters"
    }
}
