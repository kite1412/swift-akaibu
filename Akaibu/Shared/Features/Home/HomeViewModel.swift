//
//  HomeViewModel.swift
//  Akaibu
//
//  Created by kite1412 on 30/12/25.
//

import Combine

class HomeViewModel: ObservableObject {
    // TODO delete later, use AnimeRepository instead
    private let animeDataSource = DIContainer.shared.animeRemoteDataSource
    
    @Published var animeRanks: FetchResult<[MediaRank]> = .loading
    @Published var searchTitle: String = ""
    
    init() {
        Task {
            await fetchAnimeRanks()
        }
    }
    
    private func fetchAnimeRanks() async {
        animeRanks = await FetchHelpers.tryFetch(animeDataSource.fetchAnimeRanks)
    }
}
