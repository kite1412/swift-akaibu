//
//  MediaGenresView.swift
//  Akaibu
//
//  Created by kite1412 on 21/02/26.
//

import SwiftUI

struct MediaGenresView: View {
    @StateObject private var viewModel = MediaGenresViewModel()
    @State private var showGenres: Bool = true
    
    var body: some View {
        if showGenres {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 8) {
                    textSelect(name: "Anime", selected: viewModel.showingAnimeResults) {
                        viewModel.showingAnimeResults = true
                    }
                    textSelect(name: "Manga", selected: !viewModel.showingAnimeResults) {
                        viewModel.showingAnimeResults = false
                    }
                    Spacer()
                    
                    Text("Search")
                        .opacity(isAnyGenreSelected ? 1 : 0)
                        .animation(.easeInOut(duration: 0.2), value: isAnyGenreSelected)
                        .foregroundStyle(.accent)
                        .onTapGesture {
                            if isAnyGenreSelected {
                                viewModel.updateMediaFetchResults()
                                showGenres = false
                            }
                        }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                FetchStateView(
                    fetchResult: viewModel.showingAnimeResults ? viewModel.animeGenres : viewModel.mangaGenres,
                    loadingText: "Loading \(mediaType) genres...",
                    errorText: "Failed to get \(mediaType) genres."
                ) { genres in
                    ScrollView {
                        LazyVGrid(
                            columns: [GridItem(), GridItem(), GridItem()],
                            alignment: .listRowSeparatorLeading
                        ) {
                            ForEach(genres) { genre in
                                textSelect(name: genre.name, selected: viewModel.isGenreSelected(genre)) {
                                    viewModel.toggleGenre(genre)
                                }
                            }
                            .font(.caption)
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding()
            .onChange(of: viewModel.showingAnimeResults) {
                viewModel.updateMediaGenres()
            }
        } else {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    HStack {
                        Text(mediaType)
                            .font(.title)
                        
                        Spacer()
                        Text("Genres")
                            .foregroundStyle(.accent)
                            .onTapGesture {
                                showGenres = true
                            }
                    }
                    
                    Text(viewModel.selectedGenres.map(\.name).joined(separator: ", "))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal)
                .padding(.vertical, 4)
                
                FetchStateView(
                    fetchResult: viewModel.mediaFetchResults,
                    loadingText: "Loading \(mediaType)...",
                    errorText: "Failed to get \(mediaType)."
                ) { mediaList in
                    InfiniteScrollView(
                        items: mediaList,
                        loadMore: viewModel.loadMoreMediaResults
                    ) { media in
                        MediaCard(
                            media: media,
                            onClick: {_ in }
                        )
                        .padding(.horizontal)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
    }
    
    private var mediaType: String {
        viewModel.showingAnimeResults ? "Anime" : "Manga"
    }
    
    private var isAnyGenreSelected: Bool {
        !viewModel.selectedGenres.isEmpty
    }
    
    @ViewBuilder
    private func textSelect(
        name: String,
        selected: Bool,
        selectedBackground: Color = .accent,
        onClick: @escaping () -> Void
    ) -> some View {
        Text(name)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(selected ? selectedBackground : .clear)
            .foregroundStyle(selected ? .white : .primary)
            .bold()
            .animation(.easeInOut(duration: 0.2), value: selected)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .onTapGesture {
                onClick()
            }
    }
}

#Preview {
    MediaGenresView()
}
