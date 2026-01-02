//
//  MediaSearchResultsViewModel.swift
//  Akaibu
//
//  Created by kite1412 on 02/01/26.
//

import Foundation
import Combine

@MainActor
class MediaSearchResultsViewModel: ObservableObject {
    private let animeRepository = DIContainer.shared.animeRepository
    private let mangaRepository = DIContainer.shared.mangaRepository
    private var nextAnimeSearchResults: NextResultClosure<[AnimeBase]> = nil
    private var nextMangaSearchResults: NextResultClosure<[MangaBase]> = nil
    
    @Published var showAnimeSearchResults: Bool = true
    @Published var animeSearchResults: FetchResult<[AnimeBase]> = .loading
    @Published var mangaSearchResults: FetchResult<[MangaBase]> = .loading
    
    func searchByTitle(title: String) {
        Task {
            if showAnimeSearchResults {
                updateSearchResults(
                    for: &animeSearchResults,
                    nextResult: &nextAnimeSearchResults,
                    with: await FetchHelpers.tryFetch {
                        try await animeRepository.getAnimeBases(title: title)
                    }
                )
            } else {
                updateSearchResults(
                    for: &mangaSearchResults,
                    nextResult: &nextMangaSearchResults,
                    with: await FetchHelpers.tryFetch {
                        try await mangaRepository.getMangaBases(title: title)
                    }
                )
            }
        }
    }
    
    private func updateSearchResults<T>(
        for target: inout FetchResult<T>,
        nextResult: inout NextResultClosure<T>,
        with result: FetchResult<PaginatedResult<T>>
    ) {
        target = .loading
        
        switch result {
        case .success(let data):
            target = .success(data: data.data)
            nextResult = data.next
        case .failure(let error):
            target = .failure(error)
        case .loading:
            target = .loading
        }
    }
}
