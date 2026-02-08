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
        ScrollViewReader { proxy in
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
                            mediaCards(
                                for: searchResults.map { $0.toMediaCardData() },
                                loadMore: viewModel.nextAnimeSearchResults == nil ? nil : {
                                    viewModel.loadMoreAnimeResults()
                                }
                            )
                        }
                    } else {
                        FetchStateView(
                            fetchResult: viewModel.mangaSearchResults,
                            errorText: "Failed to fetch manga with title: \(searchTitle)"
                        ) { searchResults in
                            mediaCards(for: searchResults.map { $0.toMediaCardData() }) {
                                
                            }
                        }
                    }
                }
            }
            .navigationTitle("Search Results")
            .toolbar {
                ToolbarItem {
                    Picker("", selection: $viewModel.showAnimeSearchResults) {
                        Text("Anime").tag(true)
                        Text("Manga").tag(false)
                    }
                    .pickerStyle(.segmented)
                }
            }
            .onAppear {
                if !searchTitle.isEmpty {
                    viewModel.searchByTitle(title: searchTitle)
                }
            }
            .onChange(of: viewModel.showAnimeSearchResults) {
                viewModel.searchByTitle(title: searchTitle)
                withAnimation {
                    proxy.scrollTo(0, anchor: .top)
                }
            }
        }
    }
    
    private func mediaCards(for mediaCardDataList: [MediaCardData], loadMore: (() -> Void)?) -> some View {
        InfiniteScrollView(items: mediaCardDataList, loadMore: loadMore) { media in
            MediaCard(media: media)
                .padding(.horizontal)
                .padding(.vertical, 4)
        }
//        VStack(spacing: 0) {
//            ForEach(Array(mediaCardDataList.enumerated()), id: \.element.id) { index, media in
//                MediaCard(media: media)
//                    .id(index)
//                    .padding(.horizontal)
//                    .padding(.vertical, 4)
//            }
//        }
    }
}

#Preview {
    MediaSearchResultsView(searchTitle: "One Piece")
}
