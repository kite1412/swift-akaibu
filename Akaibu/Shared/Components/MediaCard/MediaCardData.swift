//
//  MediaCardData.swift
//  Akaibu
//
//  Created by kite1412 on 29/12/25.
//

import Foundation

struct MediaCardData: Identifiable {
    let id: Int
    let title: String
    let description: String?
    let coverImageURL: URL?
    let isAdult: Bool
    let genres: [String]
    let score: Double?
    let type: String
    let status: String
    let scoringUsers: Int?
}
