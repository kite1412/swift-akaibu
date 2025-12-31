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
            ScrollView {
                FetchStateView(
                    fetchResult: viewModel.animeRanks,
                    loadingText: "Loading anime ranks...",
                    errorText: "Failed to get anime ranks"
                ) { animeRanks in
                    ranking(for: "Anime", mediaRanks: animeRanks)
                }
                FetchStateView(
                    fetchResult: viewModel.mangaRanks,
                    loadingText: "Loading manga ranks...",
                    errorText: "Failed to get manga ranks"
                ) { mangaRanks in
                    ranking(for: "Anime", mediaRanks: mangaRanks)
                }
            }
            .searchable(
                text: $viewModel.searchTitle,
                placement: .toolbar,
                prompt: "Search anime or manga"
            )
        }
        .padding()
    }
    
    private func ranking(
        for mediaType: String,
        mediaRanks: [MediaRank],
        trophyImage: String = "trophy.fill"
    ) -> some View {
        VStack {
            HStack {
                HStack {
                    Image(systemName: trophyImage)
                        .font(.title2)
                        .foregroundStyle(.yellow)
                    Text("\(mediaType) Ranking")
                        .italic()
                        .font(.title2)
                        .fontWeight(.bold)
                }
                Spacer()
                Button {
                    // navigate to ranking page
                } label: {
                    Image(systemName: "arrow.right")
                }
            }
            ForEach(mediaRanks) { media in
                MediaRankCard(mediaRank: media)
            }
        }
    }
}

#Preview {
    HomeView()
}
