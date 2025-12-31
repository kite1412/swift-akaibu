//
//  MALMangaStatus.swift
//  Akaibu
//
//  Created by kite1412 on 31/12/25.
//

enum MALMangaStatus: String, Codable {
    case finished, currentlyPublishing = "currently_publishing", notYetPublished = "not_yet_published", onHiatus = "on_hiatus"
}
