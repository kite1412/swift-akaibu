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
                switch viewModel.animeRanks {
                case .loading:
                    ProgressView()
                        .progressViewStyle(.circular)
                case .success(let animeRanks):
                    ranking(for: "Anime", mediaRanks: animeRanks)
                case .failure:
                    Text("Failed to get anime ranks")
                }
                
                switch viewModel.mangaRanks {
                case .loading:
                    ProgressView()
                        .progressViewStyle(.circular)
                case .success(let mangaRanks):
                    ranking(for: "Manga", mediaRanks: mangaRanks)
                case .failure:
                    Text("Failed to get manga ranks")
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
