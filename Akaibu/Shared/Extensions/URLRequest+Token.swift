//
//  URLRequest+Token.swift
//  Akaibu
//
//  Created by kite1412 on 30/12/25.
//

import Foundation

extension URLRequest {
    mutating func attachBearerToken() {
        if let token = KeychainManager.shared.getToken() {
            self.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
    }
}
