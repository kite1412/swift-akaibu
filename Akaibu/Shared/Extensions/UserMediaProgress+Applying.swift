//
//  UserMediaProgress+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 18/02/26.
//

extension UserMediaProgress {
    func applying(_ update: (inout Self) -> Void) -> Self {
        var copy = self
        update(&copy)
        return copy
    }
}
