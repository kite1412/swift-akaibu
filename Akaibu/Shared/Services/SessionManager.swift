//
//  SessionManager.swift
//  Akaibu
//
//  Created by kite1412 on 27/12/25.
//

import Combine

class SessionManager: ObservableObject {
    @Published var isLoggedIn: Bool? = nil
    
    init() {
        _ = checkLoginStatus()
    }
    
    func checkLoginStatus() -> Bool {
        if KeychainManager.shared.getToken() != nil {
            isLoggedIn = true
            return false
        } else {
            isLoggedIn = false
            return false
        }
    }
    
    func login(token: String, refreshToken: String) {
        KeychainManager.shared.saveToken(token: token)
        KeychainManager.shared.saveRefreshToken(token: refreshToken)
        isLoggedIn = true
    }
    
    func logout() {
        _ = KeychainManager.shared.deleteToken()
        _ = KeychainManager.shared.deleteRefreshToken()
        isLoggedIn = false
    }
}
