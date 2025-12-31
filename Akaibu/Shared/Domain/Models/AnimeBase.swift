//
//  AnimeSmall.swift
//  Akaibu
//
//  Created by kite1412 on 29/12/25.
//

import Foundation

/// The very base model of an Anime data
struct AnimeBase: Identifiable {
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
}
