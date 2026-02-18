//
//  MALMangaDetail.swift
//  Akaibu
//
//  Created by kite1412 on 18/02/26.
//

import Foundation

struct MALMangaDetail: Codable {
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
    let authors: [MALAuthor]?
    let pictures: [MALPicture]?
    let background: String?
    let relatedManga: [MALRelatedManga]?
    let recommendations: [MALMangaRecommendation]?
}
