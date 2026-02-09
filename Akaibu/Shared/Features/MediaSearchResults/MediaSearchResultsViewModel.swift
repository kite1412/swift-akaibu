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
                        with: await FetchHelpers.tryFetch {
                            try await animeRepository.getAnimeBases(title: title)
                        },
                        saveNextResultTo: &nextAnimeSearchResults
                    )
                }
            } else {
                switch mangaSearchResults {
                case .success: break
                default:
                    updateSearchResults(
                        for: &mangaSearchResults,
                        with: await FetchHelpers.tryFetch {
                            try await mangaRepository.getMangaBases(title: title)
                        },
                        saveNextResultTo: &nextMangaSearchResults
                    )
                }
            }
        }
    }
    
    func loadMoreAnimeResults() {
        Task {
            let res = await FetchHelpers.tryFetch {
                if let nextAnimeSearchResults {
                    return try await nextAnimeSearchResults()
                } else {
                    return nil
                }
            }
            
            loadMoreMediaResults(
                for: &animeSearchResults,
                with: res,
                saveNextResultTo: &nextAnimeSearchResults
            )
        }
    }
    
    private func loadMoreMediaResults<T: Identifiable>(
        for target: inout FetchResult<[T]>,
        with result: FetchResult<PaginatedResult<[T]>?>,
        saveNextResultTo nextResult: inout NextResultClosure<[T]>
    ) {
        if case .success(let data) = target {
            if case .success(let newData) = result {
                target = .success(data: (data + (newData?.data ?? [])).uniqueByID())
                nextResult = newData?.next
            } else {
                nextResult = nil
            }
        }
    }
    
    private func updateSearchResults<T>(
        for target: inout FetchResult<T>,
        with result: FetchResult<PaginatedResult<T>>,
        saveNextResultTo nextResult: inout NextResultClosure<T>,
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
