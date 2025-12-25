//
//  MainView.swift
//  Akaibu
//
//  Created by kite1412 on 25/12/25.
//

import SwiftUI

struct MainView: View {
    @State private var currentDestination: Destination = .home
    
    var body: some View {
        #if os(iOS)
        iOSMainView()
        #elseif os(macOS)
        macOSMainView(currentDestination: $currentDestination)
        #endif
    }
}

#Preview {
    MainView()
}
