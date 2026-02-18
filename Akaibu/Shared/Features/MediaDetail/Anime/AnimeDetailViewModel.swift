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
    
    @Published var anime: AnimeDetail? = nil
    @Published var mediaDetail: MediaDetailData? = nil
    
    init(animeId: Int) {
        getAnimeDetail(animeId: animeId)
    }
    
    func updateUserAnimeProgress(with newProgress: UserMediaProgress) {
        if let anime {
            Task {
                let res = await FetchHelpers.tryFetch {
                    try await repository.updateUserAnimeProgress(
                        animeId: anime.id,
                        with: newProgress.toUserAnimeProgress()
                    )
                }
                
                if case .success(let data) = res {
                    updateAnime(
                        with: anime.applying { anime in
                            anime.userProgress = data
                        }
                    )
                }
            }
        }
    }
    
    private func getAnimeDetail(animeId: Int) {
        Task {
            let res = await FetchHelpers.tryFetch {
                try await repository.getAnimeDetail(withId: animeId)
            }
            
            if case .success(let data) = res {
                updateAnime(with: data)
            }
        }
    }
    
    private func updateAnime(with anime: AnimeDetail) {
        self.anime = anime
        self.mediaDetail = anime.toMediaDetailData()
    }
}
