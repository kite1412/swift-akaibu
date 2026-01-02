//
//  AkaibuApp.swift
//  Akaibu
//
//  Created by kite1412 on 24/12/25.
//

import SwiftUI

@main
struct AkaibuApp: App {
    @StateObject private var appRouter = AppRouter()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(appRouter)
        }
    }
}
