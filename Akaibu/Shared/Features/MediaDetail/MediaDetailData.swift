//
//  MediaDetailData.swift
//  Akaibu
//
//  Created by kite1412 on 14/02/26.
//

import Foundation

struct MediaDetailData {
    let title: String
    let synopsis: String?
    let coverImageURL: URL?
    let type: String
    let status: String
    let isAdult: Bool
    let genres: [String]
    let score: Double?
    let scoringUsers: Int?
    let alternativeTitles: [String]
    let rank: Int?
}
