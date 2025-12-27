//
//  HomeView.swift
//  Akaibu
//
//  Created by kite1412 on 25/12/25.
//

import SwiftUI

struct HomeView: View {
    @State private var searchTitle: String = ""
    
    var body: some View {
        ScrollView {
            Text("the main content")
        }
        .padding()
        .searchable(text: $searchTitle, prompt: "Search anime or manga")
    }
}

#Preview {
    HomeView()
}
