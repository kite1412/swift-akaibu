//
//  MediaSearchResultsView.swift
//  Akaibu
//
//  Created by kite1412 on 02/01/26.
//

import SwiftUI

struct MediaSearchResultsView: View {
    @EnvironmentObject private var appRouter: AppRouter
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
                
                if viewModel.showAnimeSearchResults {
                    FetchStateView(
                        fetchResult: viewModel.animeSearchResults,
                        errorText: "Failed to fetch anime with title: \(searchTitle)"
                    ) { searchResults in
                        mediaCards(
                            for: searchResults.map { $0.toMediaCardData() },
                            loadMore: viewModel.nextAnimeSearchResults == nil ? nil : {
                                viewModel.loadMoreAnimeResults()
                            },
                            onClick: { animeId in
                                appRouter.goToAnimeDetail(withId: animeId)
                            }
                        )
                    }
                    .frame(maxHeight: .infinity)
                } else {
                    FetchStateView(
                        fetchResult: viewModel.mangaSearchResults,
                        errorText: "Failed to fetch manga with title: \(searchTitle)"
                    ) { searchResults in
                        mediaCards(
                            for: searchResults.map { $0.toMediaCardData() },
                            loadMore: viewModel.nextMangaSearchResults == nil ? nil : {
                                viewModel.loadMoreMangaResults()
                            },
                            onClick: { mangaId in
                                appRouter.goToMangaDetail(withId: mangaId)
                            }
                        )
                    }
                    .frame(maxHeight: .infinity)
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
    
    private func mediaCards(
        for mediaCardDataList: [MediaCardData],
        loadMore: (() -> Void)?,
        onClick: @escaping (_ id: Int) -> Void
    ) -> some View {
        InfiniteScrollView(items: mediaCardDataList, loadMore: loadMore) { media in
            MediaCard(media: media, onClick: onClick)
                .padding(.horizontal)
        }
    }
}

#Preview {
    MediaSearchResultsView(searchTitle: "One Piece")
}
