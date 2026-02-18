//
//  Applying.swift
//  Akaibu
//
//  Created by kite1412 on 19/02/26.
//

protocol Applying {}

extension Applying {
    func applying(_ update: (inout Self) -> Void) -> Self {
        var copy = self
        update(&copy)
        return copy
    }
}
