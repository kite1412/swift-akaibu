//
//  MockMedia.swift
//  Akaibu
//
//  Created by kite1412 on 01/01/26.
//

import Foundation

struct MockMedia {
    private init() {}
    
    static let mediaRank = MediaRank(
        id: 1,
        title: "Media Title",
        synopsis: "Media with a very long long long long long long long long long long Synopsis",
        rank: 1,
        type: "Type",
        status: "Completed",
        coverImageURL: URL.init(string: "https://picsum.photos/300/200"),
        isAdult: true,
        score: 9.62,
        genres: ["Genre A", "Genre B"],
        scoringUsers: 100
    )
    
    static let mediaRankMinimum = MediaRank(
        id: 2,
        title: "Media Title",
        synopsis: nil,
        rank: 2,
        type: "Type",
        status: "Airing",
        coverImageURL: nil,
        isAdult: false,
        score: 9.210,
        genres: ["Genre A", "Genre B"],
        scoringUsers: 100
    )
}
