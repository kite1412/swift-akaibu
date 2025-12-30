//
//  HomeView.swift
//  Akaibu
//
//  Created by kite1412 on 25/12/25.
//

import SwiftUI
import OSLog

struct HomeView: View {
    @ObservedObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            switch viewModel.animeRanks {
            case .loading:
                ProgressView()
                    .progressViewStyle(.circular)
            case .success(let animeRanks):
                ScrollView {
                    ForEach(animeRanks) { media in
                        MediaRankCard(mediaRank: media)
                    }
                }
                .searchable(text: $viewModel.searchTitle, placement: .toolbar, prompt: "Search anime or manga")
            case .failure:
                Text("Failed to get anime ranks")
            }
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
