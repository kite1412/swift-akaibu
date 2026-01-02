//
//  SearchHistory.swift
//  Akaibu
//
//  Created by kite1412 on 02/01/26.
//

import Foundation

struct SearchHistory {
    private static let key = "searchHistory"
    
    private init() {}
    
    static var get: [String] {
        UserDefaults.standard.stringArray(forKey: key) ?? []
    }
    
    static func add(_ text: String) {
        var current = get
        current.removeAll(where: { $0 == text })
        current.insert(text, at: 0)
        if current.count > 20 {
            current = Array(current.prefix(20))
        }
        UserDefaults.standard.set(current, forKey: key)
    }
    
    static func clearAll() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
