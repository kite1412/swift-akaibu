//
//  MediaSliderData.swift
//  Akaibu
//
//  Created by kite1412 on 01/01/26.
//

import Foundation

struct MediaSliderData: Identifiable {
    let id: Int
    let title: String
    let synopsis: String?
    let coverImageUrl: URL?
    let score: Double?
    let scoringUsers: Int?
    let isAdult: Bool
    let genres: [String]
    let status: String
}
