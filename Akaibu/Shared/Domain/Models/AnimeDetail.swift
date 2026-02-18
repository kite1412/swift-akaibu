//
//  AnimeDetail.swift
//  Akaibu
//
//  Created by kite1412 on 14/02/26.
//

import Foundation

struct AnimeDetail: Applying {
    let id: Int
    let title: String
    let synopsis: String?
    let type: String
    let coverImageURL: URL?
    let rating: Rating
    let airingStatus: AiringStatus
    let genres: [String]
    let score: Double?
    let scoringUsers: Int?
    let alternativeTitles: [String]
    let startDate: Date?
    let endDate: Date?
    let startSeason: String?
    let rank: Int?
    let totalEpisodes: Int?
    var userProgress: UserAnimeProgress?
    let broadcastDate: String?
    let averageEpisodeDuration: Int?
    let studios: [String]
    let relatedAnime: [RelatedMedia]
    let recommendations: [MediaRecommendation]
}
