//
//  UserMediaData+Applying.swift
//  Akaibu
//
//  Created by kite1412 on 04/01/26.
//

extension UserMediaData {
    func applying(_ update: (inout Self) -> Void) -> Self {
        var copy = self
        update(&copy)
        return copy
    }
}
