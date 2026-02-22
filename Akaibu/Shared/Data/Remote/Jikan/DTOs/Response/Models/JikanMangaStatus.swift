//
//  JikanMangaStatus.swift
//  Akaibu
//
//  Created by kite1412 on 22/02/26.
//

enum JikanMangaStatus: String, Codable {
    case publishing = "Publishing",
         finished = "Finished",
         onHiatus = "On Hiatus",
         discontinued = "Discontinued",
         upcomging = "Upcoming"
}
