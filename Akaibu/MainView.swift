//
//  MainView.swift
//  Akaibu
//
//  Created by kite1412 on 25/12/25.
//

import SwiftUI

struct MainView: View {
    @State private var currentDestination: RootDestination = .home
    @StateObject private var session = SessionManager()
    
    var body: some View {
        Group {
            if let loggedIn = session.isLoggedIn {
                if loggedIn {
                    #if os(iOS)
                    iOSMainView(session: session)
                    #elseif os(macOS)
                    macOSMainView(currentDestination: $currentDestination, session: session)
                    #endif
                } else {
                    LoginView(session: session)
                }
            } else {
                ProgressView {
                    Text("Loading user info...")
                }
                .progressViewStyle(.circular)
            }
        }
        .animation(.easeInOut, value: session.isLoggedIn)
    }
}

#Preview {
    MainView()
}
