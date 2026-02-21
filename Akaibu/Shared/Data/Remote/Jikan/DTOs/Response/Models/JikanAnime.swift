//
//  JikanAnime.swift
//  Akaibu
//
//  Created by kite1412 on 20/02/26.
//

struct JikanAnime: Codable {
    let malId: Int
    let url: String
    let images: JikanImages
    let trailer: JikanTrailer
    let approved: Bool
    let titles: [JikanTitle]
    let title: String
    let titleEnglish: String?
    let titleJapanese: String?
    let titleSynonyms: [String]
    let type: String?
    let source: String?
    let episodes: Int?
    let status: String?
    let airing: Bool
    let aired: JikanAired
    let duration: String?
    let rating: String?
    let score: Double?
    let scoredBy: Int?
    let rank: Int?
    let popularity: Int?
    let members: Int?
    let favorites: Int?
    let synopsis: String?
    let background: String?
    let season: String?
    let year: Int?
    let broadcast: JikanBroadcast
    let producers: [JikanMALURL]
    let licensors: [JikanMALURL]
    let studios: [JikanMALURL]
    let genres: [JikanMALURL]
    let explicitGenres: [JikanMALURL]
    let themes: [JikanMALURL]
    let demographics: [JikanMALURL]
}
