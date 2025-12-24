//
//  AkaibuApp.swift
//  Akaibu
//
//  Created by kite1412 on 24/12/25.
//

import SwiftUI

@main
struct AkaibuApp: App {
    var body: some Scene {
        WindowGroup {
            #if os(iOS)
            iOSMainView()
            #elseif os(macOS)
            macOSMainView()
            #endif
        }
    }
}
