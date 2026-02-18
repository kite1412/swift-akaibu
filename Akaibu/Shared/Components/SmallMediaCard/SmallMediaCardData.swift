//
//  SmallMediaCardData.swift
//  Akaibu
//
//  Created by kite1412 on 18/02/26.
//

import Foundation

struct SmallMediaCardData: Identifiable {
    let id: Int
    let title: String
    let coverImageURL: URL?
    let description: String?
}
