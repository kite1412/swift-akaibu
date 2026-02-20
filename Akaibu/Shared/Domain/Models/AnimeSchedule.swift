//
//  AnimeSchedule.swift
//  Akaibu
//
//  Created by kite1412 on 20/02/26.
//

import Foundation

struct AnimeSchedule: Identifiable {
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
    let day: Day
    let time: String
}
