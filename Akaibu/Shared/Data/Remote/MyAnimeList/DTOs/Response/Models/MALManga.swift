//
//  MALManga.swift
//  Akaibu
//
//  Created by kite1412 on 31/12/25.
//

struct MALManga: Codable {
    let id: Int
    let title: String
    let mainPicture: MALPicture?
    let alternativeTitles: MALAlternativeTitles?
    let startDate: String?
    let endDate: String?
    let synopsis: String?
    let mean: Float?
    let rank: Int?
    let popularity: Int?
    let numListUsers: Int?
    let numScoringUsers: Int?
    let nsfw: MALNsfw?
    let genres: [MALGenre]?
    let createdAt: String?
    let updatedAt: String?
    let mediaType: MALMangaType?
    let status: MALMangaStatus?
    let myListStatus: MALUserMangaListStatus?
    let numVolumes: Int?
    let numChapters: Int?
}
