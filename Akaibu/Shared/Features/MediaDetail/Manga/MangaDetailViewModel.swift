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
    
    private func getMangaDetail(mangaId: Int) {
        Task {
            let res = await FetchHelpers.tryFetch {
                try await repository.getMangaDetail(withId: mangaId)
            }
            
            if case .success(let data) = res {
                self.manga = data
                self.mediaDetail = data.toMediaDetailData()
            }
        }
    }
}
