//
//  MangaDetailViewModel.swift
//  Akaibu
//
//  Created by kite1412 on 18/02/26.
//

import Combine

@MainActor
class MangaDetailViewModel: ObservableObject {
    private let repository = DIContainer.shared.mangaRepository
    
    @Published var manga: MangaDetail? = nil
    @Published var mediaDetail: MediaDetailData? = nil
    
    init(mangaId: Int) {
        getMangaDetail(mangaId: mangaId)
    }
    
    func updateUserMangaProgress(with newProgress: UserMediaProgress) {
        if let manga {
            Task {
                let res = await FetchHelpers.tryFetch {
                    try await repository.updateUserMangaProgress(
                        mangaId: manga.id,
                        with: newProgress.toUserMangaProgress()
                    )
                }
                
                if case .success(let data) = res {
                    updateManga(
                        with: manga.applying { manga in
                            manga.userProgress = data
                        }
                    )
                }
            }
        }
    }
    
    func deleteUserMangaProgress() {
        if let manga {
            Task {
                let res = await FetchHelpers.tryFetch {
                    try await repository.deleteUserMangaProgress(withId: manga.id)
                }
                
                if case .success = res {
                    updateManga(
                        with: manga.applying { manga in
                            manga.userProgress = nil
                        }
                    )
                }
            }
        }
    }
    
    private func getMangaDetail(mangaId: Int) {
        Task {
            let res = await FetchHelpers.tryFetch {
                try await repository.getMangaDetail(withId: mangaId)
            }
            
            if case .success(let data) = res {
                updateManga(with: data)
            }
        }
    }
    
    private func updateManga(with manga: MangaDetail) {
        self.manga = manga
        self.mediaDetail = manga.toMediaDetailData()
    }
}
