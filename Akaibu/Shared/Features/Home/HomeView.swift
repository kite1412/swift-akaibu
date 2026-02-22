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
    @EnvironmentObject private var appRouter: AppRouter
    @StateObject private var viewModel = HomeViewModel()
    @State private var shake: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                FetchStateView(
                    fetchResult: viewModel.animeSuggestions,
                    loadingText: "Loading anime suggestions...",
                    errorText: "Failed to get anime suggestions"
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
                        
                        MediaSlider(
                            data: suggestions,
                            onClick: { animeId in
                                appRouter.goToAnimeDetail(withId: animeId)
                            }
                        )
                    }
                }
                FetchStateView(
                    fetchResult: viewModel.animeSchedules,
                    loadingText: "Loading anime schedules...",
                    errorText: "Failed to get anime schedules"
                ) { schedules in
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            HStack(spacing: 8) {
                                Image(systemName: "antenna.radiowaves.left.and.right")
                                    .rotationEffect(.degrees(shake ? 8 : -8))
                                    .animation(
                                        .easeInOut(duration: 0.2)
                                        .repeatForever(autoreverses: true),
                                        value: shake
                                    )
                                    .onAppear {
                                        shake = true
                                    }
                                
                                Text("Airing Today")
                                    .italic()
                                    .bold()
                            }
                            .font(.title2)
                            .foregroundStyle(.green)
                            
                            Spacer()
                            Button(action: appRouter.goToAnimeSchedules) {
                                Label("Schedule", systemImage: "calendar")
                            }
                        }
                        
                        ScrollView(.horizontal) {
                            LazyHStack(alignment: .top) {
                                ForEach(schedules) { data in
                                    let compareResult = data.day.compare(to: Day.today())
                                    
                                    SmallMediaCard(
                                        data: data.toSmallMediaCardData(),
                                        onClick: appRouter.goToAnimeDetail
                                    )
                                    .applyIf(compareResult == 1 || compareResult == -1) { view in
                                        view.foregroundStyle(
                                            compareResult == 1 ? .green : .red
                                        )
                                    }
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.horizontal)
                
                if horizontalSizeClass == .compact {
                    mediaRanking
                } else {
                    HStack(spacing: 16) {
                        mediaRanking
                    }
                }
            }
        }
        .alert("Clear all history?", isPresented: $viewModel.showClearHistoryConfirmation) {
            Button("Cancel", role: .cancel) {
                viewModel.showClearHistoryConfirmation.toggle()
            }
            Button("Clear", role: .destructive) {
                viewModel.clearHistories()
                viewModel.showClearHistoryConfirmation.toggle()
            }
        }
        .searchable(
            text: $viewModel.searchTitle,
            placement: .toolbar,
            prompt: "Search anime or manga"
        )
        .searchSuggestions {
            if viewModel.searchTitle.isEmpty {
                if !viewModel.searchHistories.isEmpty {
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Spacer()
                            Label("Clear History", systemImage: "xmark.circle")
                        }
                        .foregroundStyle(.red)
                        .onTapGesture {
                            viewModel.showClearHistoryConfirmation.toggle()
                        }
                        
                        VStack(alignment: .leading) {
                            ForEach(viewModel.searchHistories, id: \.self) { history in
                                VStack(alignment: .leading) {
                                    Text(history)
                                        .lineLimit(1)
                                        .truncationMode(.tail)
                                    
                                    Divider()
                                }
                                .frame(maxWidth: .infinity)
                                .onTapGesture {
                                    viewModel.searchTitle = history
                                }
                            }
                        }
                    }
                } else {
                    Text("No Search History")
                }
            } else {
                ZStack {
                    if viewModel.searchTitle.count > 2 {
                        LazyVStack(alignment: .leading, pinnedViews: [.sectionHeaders]) {
                            Section(
                                header: Text("Result for \"\(self.viewModel.searchTitle)\"")
                                    .lineLimit(1)
                                    .truncationMode(.middle)
                            ) {
                                FetchStateView(
                                    fetchResult: viewModel.animeSearchResult
                                ) { data in
                                    ForEach(data) { anime in
                                        MediaCard(media: anime.toMediaCardData(), onClick: appRouter.goToAnimeDetail)
                                    }
                                    .frame(maxWidth: .infinity)
                                }
                                .frame(maxWidth: .infinity)
                            }
                        }
                    } else {
                        Text("Type at least 3 characters.")
                    }
                }
                .task(id: viewModel.searchTitle) {
                    if viewModel.searchTitle.count > 2 {
                        try? await Task.sleep(nanoseconds: 300_000_000)
                        try? await viewModel.updateAnimeSearchResult()
                    }
                }
            }
        }
        .onSubmit(of: .search) {
            if !viewModel.showClearHistoryConfirmation && viewModel.searchTitle.count > 2 {
                viewModel.addToHistory()
                appRouter.goToMediaSearchResults(withTitle: viewModel.searchTitle)
            }
        }
    }
    
    @ViewBuilder
    private var mediaRanking: some View {
        FetchStateView(
            fetchResult: viewModel.animeRanks,
            loadingText: "Loading anime ranks...",
            errorText: "Failed to get anime ranks"
        ) { animeRanks in
            ranking(
                for: "Anime",
                mediaRanks: animeRanks,
                onMediaClick: appRouter.goToAnimeDetail,
                onMoreClick: appRouter.goToAnimeRanking
            )
        }
        FetchStateView(
            fetchResult: viewModel.mangaRanks,
            loadingText: "Loading manga ranks...",
            errorText: "Failed to get manga ranks"
        ) { mangaRanks in
            ranking(
                for: "Manga",
                mediaRanks: mangaRanks,
                onMediaClick: appRouter.goToMangaDetail,
                onMoreClick: appRouter.goToMangaRanking,
                trophyImage: "trophy"
            )
        }
    }
    
    private func ranking(
        for mediaType: String,
        mediaRanks: [MediaRank],
        onMediaClick: @escaping (_ id: Int) -> Void,
        onMoreClick: @escaping () -> Void,
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
                Button(action: onMoreClick) {
                    Image(systemName: "arrow.right")
                }
            }
            ForEach(mediaRanks) { media in
                MediaRankCard(mediaRank: media, onClick: onMediaClick)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    HomeView()
}
