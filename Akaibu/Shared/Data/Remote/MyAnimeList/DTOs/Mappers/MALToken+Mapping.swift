//
//  MALToken+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 29/12/25.
//

extension MALToken {
    func toDomain() -> Token {
        Token(accessToken: self.accessToken, refreshToken: self.refreshToken)
    }
}
