//
//  JikanGenres+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 21/02/26.
//

extension JikanGenres {
    func toStrings() -> [String] {
        self.data.map(\.name)
    }
}
