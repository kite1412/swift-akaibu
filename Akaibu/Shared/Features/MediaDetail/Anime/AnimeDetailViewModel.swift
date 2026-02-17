//
//  AnimeDetailViewModel.swift
//  Akaibu
//
//  Created by kite1412 on 17/02/26.
//

import Combine

@MainActor
class AnimeDetailViewModel: ObservableObject {
    private let repository: AnimeRepository = DIContainer.shared.animeRepository
    private var anime: AnimeDetail? = nil
    
    @Published var mediaDetail: MediaDetailData? = nil
    
    init(animeId: Int) {
        getAnimeDetail(animeId: animeId)
    }
    
    private func getAnimeDetail(animeId: Int) {
        Task {
            let res = await FetchHelpers.tryFetch {
                try await repository.getAnimeDetail(withId: animeId)
            }
            
            if case .success(let data) = res {
                self.anime = data
                self.mediaDetail = data.toMediaDetailData()
            }
        }
    }
}
