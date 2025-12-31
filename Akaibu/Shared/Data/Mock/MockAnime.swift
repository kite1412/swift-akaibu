//
//  MockAnime.swift
//  Akaibu
//
//  Created by kite1412 on 01/01/26.
//

import Foundation

struct MockAnime {
    private init() {}
    
    static let animeBase = AnimeBase(
        id: 1,
        title: "A very long long long Title",
        synopsis: "A very long long long long long long long long long long long synopsis of A Title",
        type: "A type",
        coverImageURL: URL.init(string: "https://picsum.photos/300/200"),
        rating: .safe,
        airingStatus: .airing,
        genres: ["Fantasy", "Slice Of Life", "Action", "Comedy", "Drama"],
        score: 9.8,
        scoringUsers: 10000
    )
    
    static let animeBaseMinimum = AnimeBase(
        id: 2,
        title: "A very long long long Title",
        synopsis: nil,
        type: "A type",
        coverImageURL: nil,
        rating: .safe,
        airingStatus: .airing,
        genres: ["Fantasy", "Slice Of Life", "Action"],
        score: nil,
        scoringUsers: nil
    )
}
