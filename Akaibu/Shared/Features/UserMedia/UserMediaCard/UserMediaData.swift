//
//  UserMediaData.swift
//  Akaibu
//
//  Created by kite1412 on 03/01/26.
//

import Foundation

struct UserMediaData: Identifiable, Hashable {
    let id: Int
    let title: String
    let synopsis: String?
    let coverImageUrl: URL?
    let isAdult: Bool
    let score: Double?
    let scoringUsers: Int?
    let genres: [String]
    let status: String
    let type: String
    let totalUnits: Int?
    var userStatus: String
    var userScore: Int
    var consumedUnits: Int
    var updatedAt: Date
}
