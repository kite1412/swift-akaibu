//
//  MALAnime.swift
//  Akaibu
//
//  Created by kite1412 on 29/12/25.
//

import Foundation

struct MALAnime: Codable {
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
    let mediaType: MALAnimeType?
    let status: MALAnimeStatus?
    let myListStatus: MALMyAnimeListStatus?
    let numEpisodes: Int?
    let startSeason: MALStartSeason?
    let broadcast: MALBroadcast?
    let source: String?
    let averageEpisodeDuration: Int?
    let rating: MALRating?
    let studios: [MALStudio]?
}
