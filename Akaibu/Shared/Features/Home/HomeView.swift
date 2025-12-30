//
//  HomeView.swift
//  Akaibu
//
//  Created by kite1412 on 25/12/25.
//

import SwiftUI
import OSLog

struct HomeView: View {
    // TODO delete later, use AnimeRepository instead
    private let animeDataSource = DIContainer.shared.animeRemoteDataSource
    @State private var searchTitle: String = ""
    @State private var animeRanks: [MediaRank] = []
    
    var body: some View {
        ScrollView {
            ForEach(animeRanks) { media in
                MediaRankCard(mediaRank: media)
            }
        }
        .task {
            await getAnimeRanks()
        }
        .padding()
        .searchable(text: $searchTitle, prompt: "Search anime or manga")
    }
    
    private func getAnimeRanks() async {
        do {
            let res = try await animeDataSource.fetchAnimeRanks()
            animeRanks += res
        } catch {
            // TODO implement error handling
            AppLogger.network.error("\(error)")
        }
    }
}

#Preview {
    HomeView()
}
