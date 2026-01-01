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
        let res = await FetchHelpers.tryFetch(animeRepository.getAnimeRanks)
        
        switch res {
        case .success(let data):
            animeRanks = .success(data: data.data)
        case .failure(let error):
            animeRanks = .failure(error)
        case .loading:
            animeRanks = .loading
        }
    }
    
    private func fetchMangaRanks() async {
        mangaRanks = await FetchHelpers.tryFetch(mangaRepository.getMangaRanks)
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
}
