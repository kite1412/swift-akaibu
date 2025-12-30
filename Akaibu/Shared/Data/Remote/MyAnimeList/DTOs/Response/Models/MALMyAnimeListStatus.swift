//
//  MALMyAnimeListStatus.swift
//  Akaibu
//
//  Created by kite1412 on 29/12/25.
//

import Foundation

struct MALMyAnimeListStatus: Codable {
    let status: MALMyAnimeStatus
    let score: Int
    let numEpisodesWatched: Int
    let isRewatching: Bool
    let updatedAt: String
    let startDate: String
}
