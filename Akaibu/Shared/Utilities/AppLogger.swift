//
//  AppLogger.swift
//  Akaibu
//
//  Created by kite1412 on 28/12/25.
//

import OSLog

struct AppLogger {
    private static let subsystem = "kite1412.Akaibu"
    
    static let auth = Logger(subsystem: subsystem, category: "Auth")
    static let network = Logger(subsystem: subsystem, category: "Network")
    static let data = Logger(subsystem: subsystem, category: "Data")
    
    private init() {}
}
