//
//  Secrets.swift
//  Akaibu
//
//  Created by kite1412 on 28/12/25.
//

import Foundation
import CryptoKit

struct Secrets {
    static let malClientId: String = {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "MAL_CLIENT_ID") as? String else {
            fatalError("MAL_CLIENT_ID not set in Info.plist")
        }
        return key
    }()
    
    static let malClientSecret: String = {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "MAL_CLIENT_SECRET") as? String else {
            fatalError("MAL_CLIENT_SECRET not set in Info.plist")
        }
        return key
    }()
    
    static let codeVerifier: String = {
        let characters = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
        var result = ""
        for _ in 0..<128 {
            if let randomChar = characters.randomElement() {
                result.append(randomChar)
            }
        }
        return result
    }()
    
    private init() {}
}
