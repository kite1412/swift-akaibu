//
//  UserManga.swift
//  Akaibu
//
//  Created by kite1412 on 06/01/26.
//

import Foundation

struct UserManga: Identifiable {
    let id: Int
    let title: String
    let synopsis: String?
    let coverImageUrl: URL?
    let isAdult: Bool
    let score: Double?
    let scoringUsers: Int?
    let genres: [String]
    let publishingStatus: PublishingStatus
    let type: String
    let totalChapters: Int?
    var progress: UserMangaProgress
}
