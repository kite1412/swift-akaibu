//
//  MALRelatedAnime.swift
//  Akaibu
//
//  Created by kite1412 on 14/02/26.
//

import Foundation

struct MALRelatedAnime: Codable {
    let node: MALAnime
    let relationType: String
    let relationTypeFormatted: String
}
