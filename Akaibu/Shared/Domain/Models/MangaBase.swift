//
//  MangaBase.swift
//  Akaibu
//
//  Created by kite1412 on 31/12/25.
//

import Foundation

/// The very base model of a Manga data
struct MangaBase: Identifiable {
    let id: Int
    let title: String
    let description: String?
    let type: String
    let coverImageURL: URL?
    let isAdult: Bool
    let publishingStatus: PublishingStatus
    let genres: [String]
    let score: Double?
    let scoringUsers: Int?
}
