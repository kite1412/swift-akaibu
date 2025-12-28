//
//  Debug.swift
//  Akaibu
//
//  Created by kite1412 on 28/12/25.
//

func debugOnly(_ body: () -> Void) {
    #if DEBUG
    body()
    #endif
}
