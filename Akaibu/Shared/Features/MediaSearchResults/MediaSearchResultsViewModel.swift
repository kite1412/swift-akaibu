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
    @Published var nextAnimeSearchResults: NextResultClosure<[AnimeBase]> = nil
    @Published var nextMangaSearchResults: NextResultClosure<[MangaBase]> = nil
    
    @Published var showAnimeSearchResults: Bool = true
    @Published var animeSearchResults: FetchResult<[AnimeBase]> = .loading
    @Published var mangaSearchResults: FetchResult<[MangaBase]> = .loading
    
    func searchByTitle(title: String) {
        Task {
            if showAnimeSearchResults {
                switch animeSearchResults {
                case .success: break
                default:
                    updateSearchResults(
                        for: &animeSearchResults,
                        nextResult: &nextAnimeSearchResults,
                        with: await FetchHelpers.tryFetch {
                            try await animeRepository.getAnimeBases(title: title)
                        }
                    )
                }
            } else {
                switch mangaSearchResults {
                case .success: break
                default:
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
    }
    
    func loadMoreAnimeResults() {
        if case .success(let data) = animeSearchResults {
            if let nextAnimeSearchResults {
                Task {
                    let res = await FetchHelpers.tryFetch(nextAnimeSearchResults)
                    
                    if case .success(let newData) = res {
                        animeSearchResults = .success(data: (data + (newData?.data ?? [])).uniqueByID())
                        self.nextAnimeSearchResults = newData?.next
                    } else {
                        self.nextAnimeSearchResults = nil
                    }
                }
            }
        }
    }
    
    private func loadMoreMediaResults<T>(
        for target: inout FetchResult<[T]>,
        with nextResult: inout NextResultClosure<[T]>
    ) async {
        if case .success(let data) = target {
            if let next = nextResult {
                let res = await FetchHelpers.tryFetch(next)
                
                if case .success(let newData) = res {
                    target = .success(data: data + (newData?.data ?? []))
                    nextResult = newData?.next
                }
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
