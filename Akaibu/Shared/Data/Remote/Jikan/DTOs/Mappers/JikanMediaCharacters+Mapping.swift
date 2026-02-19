//
//  JikanMediaCharacters+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 20/02/26.
//

extension JikanMediaCharacters {
    func toDomain() -> [Character] {
        data.map { node in
            Character(
                id: node.character.malId,
                name: node.character.name,
                imageURL: node.character.images.jpgURL(),
                role: node.role
            )
        }
    }
}
