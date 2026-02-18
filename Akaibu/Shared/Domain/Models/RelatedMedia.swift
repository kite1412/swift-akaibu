//
//  RelatedMedia.swift
//  Akaibu
//
//  Created by kite1412 on 14/02/26.
//

import Foundation

struct RelatedMedia: Identifiable {
    let id: Int
    let title: String
    let coverImageURL: URL?
    let relationType: String
}
