//
//  MediaSearchResultsView.swift
//  Akaibu
//
//  Created by kite1412 on 02/01/26.
//

import SwiftUI

struct MediaSearchResultsView: View {
    @StateObject private var viewModel = MediaSearchResultsViewModel()
    
    let searchTitle: String
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("Results for ")
                Text("\"\(searchTitle)\"")
                    .italic()
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .fontWeight(.bold)
            
            ScrollView {
                if viewModel.showAnimeSearchResults {
                    FetchStateView(
                        fetchResult: viewModel.animeSearchResults,
                        errorText: "Failed to fetch anime with title: \(searchTitle)"
                    ) { searchResults in
                        mediaCards(for: searchResults.map { $0.toMediaCardData() })
                    }
                } else {
                    FetchStateView(
                        fetchResult: viewModel.mangaSearchResults,
                        errorText: "Failed to fetch manga with title: \(searchTitle)"
                    ) { searchResults in
                        mediaCards(for: searchResults.map { $0.toMediaCardData() })
                    }
                }
            }
        }
        .navigationTitle("Search Results")
        .onAppear {
            if !searchTitle.isEmpty {
                viewModel.searchByTitle(title: searchTitle)
            }
        }
    }
    
    private func mediaCards(for mediaCardDataList: [MediaCardData]) -> some View {
        VStack {
            ForEach(mediaCardDataList) { media in
                MediaCard(media: media)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

#Preview {
    MediaSearchResultsView(searchTitle: "One Piece")
}
