//
//  MainView.swift
//  Akaibu
//
//  Created by kite1412 on 25/12/25.
//

import SwiftUI

struct MainView: View {
    @State private var currentDestination: Destination = .home
    @StateObject private var session = SessionManager()
    
    var body: some View {
        Group {
            if session.isLoggedIn {
                #if os(iOS)
                iOSMainView()
                #elseif os(macOS)
                macOSMainView(currentDestination: $currentDestination)
                #endif
            } else {
                LoginView()
            }
        }
        .animation(.easeInOut, value: session.isLoggedIn)
        .onAppear {
            _ = session.checkLoginStatus()
        }
    }
}

#Preview {
    MainView()
}
