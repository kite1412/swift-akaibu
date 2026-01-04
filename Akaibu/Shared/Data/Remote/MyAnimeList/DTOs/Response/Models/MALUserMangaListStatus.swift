//
//  MALUserMangaListStatus.swift
//  Akaibu
//
//  Created by kite1412 on 31/12/25.
//

struct MALUserMangaListStatus: Codable {
    let status: MALUserMangaStatus?
    let score: Int
    let numVolumesRead: Int
    let numChaptersRead: Int
    let isRereading: Bool?
    let startDate: String?
    let finishDate: String?
    let priority: Int?
    let numTimesReread: Int?
    let rereadValue: Int?
    let tags: [String]?
    let comments: String?
    let updatedAt: String
}
