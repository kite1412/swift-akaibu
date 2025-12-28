//
//  KeychainManager.swift
//  Akaibu
//
//  Created by kite1412 on 27/12/25.
//

import Foundation
import Security

struct KeychainManager {
    static let shared = KeychainManager()
    
    private let tokenEntry = "userToken"
    private let refreshTokenEntry = "userRefreshToken"
    
    private init() {}
    
    func saveToken(token: String) {
        store(for: tokenEntry, value: token)
    }

    func getToken() -> String? {
        get(for: tokenEntry)
    }

    func deleteToken() -> Bool {
        delete(for: tokenEntry)
    }
    
    func saveRefreshToken(token: String) {
        store(for: refreshTokenEntry, value: token)
    }
    
    func getRefreshToken() -> String? {
        get(for: refreshTokenEntry)
    }
    
    func deleteRefreshToken() -> Bool {
        delete(for: refreshTokenEntry)
    }
    
    private func store(for entry: String, value token: String) {
        let data = token.data(using: .utf8)!
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: entry,
            kSecValueData as String: data
        ]
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }
    
    private func get(for entry: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: entry,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var dataTypeRef: AnyObject? = nil
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        if status == errSecSuccess, let data = dataTypeRef as? Data {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    private func delete(for entry: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: entry
        ]
        let status = SecItemDelete(query as CFDictionary)
        
        return status == errSecSuccess
    }
}
