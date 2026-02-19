//
//  JikanImages+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 20/02/26.
//

import Foundation

extension JikanImages {
    func jpgURL() -> URL? {
        if let imageURL = jpg.imageUrl {
            return URL(string: imageURL)
        } else {
            return nil
        }
    }
}
