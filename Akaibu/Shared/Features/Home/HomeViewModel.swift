//
//  HomeViewModel.swift
//  Akaibu
//
//  Created by kite1412 on 30/12/25.
//

import Combine

class HomeViewModel: ObservableObject {
    private let animeRepository = DIContainer.shared.animeRepository
    private let mangaRepository = DIContainer.shared.mangaRepository
    private let mediaRanksLimit = 5
    
    @Published var animeRanks: FetchResult<[MediaRank]> = .loading
    @Published var mangaRanks: FetchResult<[MediaRank]> = .loading
    @Published var animeSuggestions: FetchResult<[MediaSliderData]> = .loading
    @Published var searchTitle: String = ""
    
    init() {
        Task {
            await fetchAnimeSuggestions()
            await fetchAnimeRanks()
            await fetchMangaRanks()
        }
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
        let res = await FetchHelpers.tryFetch(animeRepository.getAnimeSuggestions)
        
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
