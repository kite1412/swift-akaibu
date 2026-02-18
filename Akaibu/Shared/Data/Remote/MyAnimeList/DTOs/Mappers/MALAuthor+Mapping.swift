//
//  MALAuthor+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 18/02/26.
//

extension MALAuthor {
    func toDomain() -> Author? {
        if node.firstName == nil && node.lastName == nil {
            return nil
        } else {
            return Author(firstName: node.firstName ?? "", lastName: node.lastName ?? "", role: role)
        }
    }
}
