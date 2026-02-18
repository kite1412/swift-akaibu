//
//  MangaDetail.swift
//  Akaibu
//
//  Created by kite1412 on 18/02/26.
//

import Foundation

struct MangaDetail {
    let id: Int
    let title: String
    let synopsis: String?
    let type: String
    let coverImageURL: URL?
    let isAdult: Bool
    let publishingStatus: PublishingStatus
    let genres: [String]
    let score: Double?
    let scoringUsers: Int?
    let alternativeTitles: [String]
    let startDate: Date?
    let endDate: Date?
    let rank: Int?
    let totalChapters: Int?
    let totalVolumes: Int?
    let authors: [Author]
    let userProgress: UserMangaProgress?
    let relatedManga: [RelatedManga]
    let recommendations: [MediaRecommendation]
}
