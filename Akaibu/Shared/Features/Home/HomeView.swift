//
//  HomeView.swift
//  Akaibu
//
//  Created by kite1412 on 25/12/25.
//

import SwiftUI
import OSLog

struct HomeView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @ObservedObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                FetchStateView(
                    fetchResult: viewModel.animeSuggestions,
                    loadingText: "Loading anime suggestions...",
                    errorText: "Failure to get anime suggestions"
                ) { suggestions in
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Image(systemName: "sparkles.2")
                                .foregroundStyle(.blue)
                            Text("Anime Suggestions")
                        }
                        .font(.title2)
                        .fontWeight(.bold)
                        .italic()
                        .padding(.leading, 8) // from MediaSlider frame to outer padding
                        
                        MediaSlider(data: suggestions)
                    }
                }
                if horizontalSizeClass == .compact {
                    mediaRanking
                } else {
                    HStack(spacing: 16) {
                        mediaRanking
                    }
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
    
    @ViewBuilder
    private var mediaRanking: some View {
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
            ranking(for: "Manga", mediaRanks: mangaRanks, trophyImage: "trophy")
        }
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
