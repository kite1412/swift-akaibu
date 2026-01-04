//
//  MALUserAnimeListStatus.swift
//  Akaibu
//
//  Created by kite1412 on 29/12/25.
//

import Foundation

struct MALUserAnimeListStatus: Codable {
    let status: MALUserAnimeStatus
    let score: Int
    let numEpisodesWatched: Int
    let isRewatching: Bool
    let updatedAt: String
    let startDate: String?
    let finishDate: String?
    let priority: Int?
    let numTimesRewatched: Int?
    let rewatchValue: Int?
    let tags: [String]?
    let comments: String?
}
