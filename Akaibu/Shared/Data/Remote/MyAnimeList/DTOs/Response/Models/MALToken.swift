//
//  MALToken.swift
//  Akaibu
//
//  Created by kite1412 on 28/12/25.
//

struct MALToken: Codable {
    let tokenType: String
    let expiresIn: Int
    let accessToken: String
    let refreshToken: String
}
