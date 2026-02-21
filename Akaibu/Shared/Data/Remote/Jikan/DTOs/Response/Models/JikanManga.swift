//
//  JikanManga.swift
//  Akaibu
//
//  Created by kite1412 on 22/02/26.
//

struct JikanManga: Codable {
    let malId: Int
    let url: String
    let images: JikanImages
    let trailer: JikanTrailer
    let approved: Bool
    let titles: [JikanTitle]
    let title: String
    let titleEnglish: String?
    let titleJapanese: String
    let titleSynonyms: [String]
    let type: String?
    let chapters: Int?
    let volumes: Int?
    let status: JikanMangaStatus?
    let publishing: Bool
    let published: JikanAired
    let score: Double?
    let scoredBy: Int?
    let rank: Int?
    let popularity: Int?
    let members: Int?
    let favorites: Int?
    let synopsis: String?
    let background: String?
    let authors: [JikanMALURL]
    let serializations: [JikanMALURL]
    let genres: [JikanMALURL]
    let explicitGenres: [JikanMALURL]
    let themes: [JikanMALURL]
    let demographics: [JikanMALURL]
}
