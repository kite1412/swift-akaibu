//
//  UserAnime.swift
//  Akaibu
//
//  Created by kite1412 on 04/01/26.
//

import Foundation

struct UserAnime: Identifiable {
    let id: Int
    let title: String
    let synopsis: String?
    let coverImageUrl: URL?
    let rating: Rating
    let score: Double?
    let scoringUsers: Int?
    let genres: [String]
    let airingStatus: AiringStatus
    let type: String
    let totalEpisodes: Int?
    var progress: UserAnimeProgress
}
