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
    let coverImageURL: URL?
    let day: Day
    let time: String
}
