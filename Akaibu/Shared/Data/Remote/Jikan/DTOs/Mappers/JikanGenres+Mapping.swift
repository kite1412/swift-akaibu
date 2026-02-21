//
//  JikanGenres+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 21/02/26.
//

extension JikanGenres {
    func toDomain() -> [Genre] {
        self.data.map { genre in
            Genre(id: genre.malId, name: genre.name)
        }
    }
}
