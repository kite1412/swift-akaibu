//
//  SessionManager.swift
//  Akaibu
//
//  Created by kite1412 on 27/12/25.
//

import Combine

class SessionManager: ObservableObject {
    @Published var isLoggedIn: Bool = false
    
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
}
