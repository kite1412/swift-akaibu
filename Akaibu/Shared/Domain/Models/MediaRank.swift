//
//  MediaRank.swift
//  Akaibu
//
//  Created by kite1412 on 30/12/25.
//

import Foundation

struct MediaRank: Identifiable {
    let id: Int
    let title: String
    let synopsis: String?
    let rank: Int
    let type: String
    let status: String
    let coverImageURL: URL?
    let isAdult: Bool
    let score: Double
}
