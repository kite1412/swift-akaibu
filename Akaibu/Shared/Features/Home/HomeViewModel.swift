//
//  HomeViewModel.swift
//  Akaibu
//
//  Created by kite1412 on 30/12/25.
//

import Combine
import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    private let animeRepository = DIContainer.shared.animeRepository
    private let mangaRepository = DIContainer.shared.mangaRepository
    private let mediaRanksLimit = 5
    private var nextAnimeSearchResults: NextResultClosure<[AnimeBase]>? = nil
    private var nextMangaSearchResults: NextResultClosure<[MangaBase]>? = nil
    
    @Published var animeRanks: FetchResult<[MediaRank]> = .loading
    @Published var mangaRanks: FetchResult<[MediaRank]> = .loading
    @Published var animeSuggestions: FetchResult<[MediaSliderData]> = .loading
    @Published var searchHistories: [String] = []
    @Published var searchTitle: String = ""
    @Published var showClearHistoryConfirmation: Bool = false
    @Published var showSearchResults: Bool = false
    @Published var showAnimeSearchResults: Bool = false
    @Published var animeSearchResults: FetchResult<[AnimeBase]> = .loading
    @Published var mangaSearchResults: FetchResult<[MangaBase]> = .loading
    
    init() {
        Task {
            await fetchAnimeSuggestions()
            await fetchAnimeRanks()
            await fetchMangaRanks()
            searchHistories = SearchHistory.get
        }
    }
    
    func addToHistory() {
        let trimmed = searchTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        
        SearchHistory.add(trimmed)
        searchHistories = SearchHistory.get
    }
    
    func clearHistories() {
        SearchHistory.clearAll()
        searchHistories = []
    }
    
    private func fetchAnimeRanks() async {
        updateMediaRanks(
            for: &animeRanks,
            with: await FetchHelpers.tryFetch {
                try await animeRepository.getAnimeRanks(limit: mediaRanksLimit)
            }
        )
    }
    
    private func fetchMangaRanks() async {
        updateMediaRanks(
            for: &mangaRanks,
            with: await FetchHelpers.tryFetch {
                try await mangaRepository.getMangaRanks(limit: mediaRanksLimit)
            }
        )
    }
    
    private func fetchAnimeSuggestions() async {
        let res = await FetchHelpers.tryFetch {
            try await animeRepository.getAnimeSuggestions()
        }
        
        switch res {
        case .loading: animeSuggestions = .loading
        case .failure(let error): animeSuggestions = .failure(error)
        case .success(let data):
            animeSuggestions = .success(
                data: data.data.map { anime in
                    anime.toMediaSliderData()
                }
            )
        }
    }
    
    private func updateMediaRanks(
        for target: inout FetchResult<[MediaRank]>,
        with result: FetchResult<PaginatedResult<[MediaRank]>>
    ) {
        switch result {
        case .success(let data): target = .success(data: data.data)
        case .failure(let error):
            target = .failure(error)
        case .loading:
            target = .loading
        }
    }
}
