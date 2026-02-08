//
//  Collection+Identifiable.swift
//  Akaibu
//
//  Created by kite1412 on 08/02/26.
//

extension Collection where Element : Identifiable {
    func uniqueByID() -> [Element] {
        var seen = Set<Element.ID>()
        return self.filter { seen.insert($0.id).inserted }
    }
}
