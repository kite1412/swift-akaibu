//
//  MALMangaType.swift
//  Akaibu
//
//  Created by kite1412 on 31/12/25.
//

enum MALMangaType: String, Codable {
    case unknown, manga, oneShot = "one_shot", novel, doujinshi, manhwa, manhua, oel, lightNovel = "light_novel"
    
    var displayName: String {
        switch self {
        case .unknown: return "Unknown"
        case .manga: return "Manga"
        case .oneShot: return "One-Shot"
        case .novel: return "Novel"
        case .doujinshi: return "Doujinshi"
        case .manhwa: return "Manhwa"
        case .manhua: return "Manhua"
        case .oel: return "OEL"
        case .lightNovel: return "Light Novel"
        }
    }
}
