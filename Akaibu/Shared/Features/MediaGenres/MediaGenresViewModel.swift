//
//  MediaGenresViewModel.swift
//  Akaibu
//
//  Created by kite1412 on 21/02/26.
//

import Combine

@MainActor
class MediaGenresViewModel: ObservableObject {
    private let animeRepository = DIContainer.shared.animeRepository
    private let mangaRepository = DIContainer.shared.mangaRepository
    var nextResult: NextResultClosure<[MediaCardData]> = nil
    
    @Published var showingAnimeResults: Bool = true
    @Published var animeGenres: FetchResult<[Genre]> = .loading
    @Published var mangaGenres: FetchResult<[Genre]> = .loading
    @Published var selectedGenres: [Genre] = []
    @Published var mediaFetchResults: FetchResult<[MediaCardData]> = .loading
    
    init() {
        updateMediaGenres()
    }
    
    func updateMediaFetchResults() {
        Task {
            mediaFetchResults = .loading
            
            if showingAnimeResults {
                await updateMediaFetchResults(
                    with: {
                        try await animeRepository.getAnimeByGenres(selectedGenres)
                    },
                    mapper: animeToMediaCardData
                )
            } else {
                await updateMediaFetchResults(
                    with: {
                        try await mangaRepository.getMangaByGenres(selectedGenres)
                    },
                    mapper: mangaToMediaCardData
                )
            }
        }
    }
    
    func updateMediaGenres() {
        Task {
            selectedGenres.removeAll()
            if showingAnimeResults {
                if case .success = animeGenres {
                    return
                } else {
                    let res = await FetchHelpers.tryFetch(animeRepository.getAnimeGenres)
                    
                    if case .success(let data) = res {
                        self.animeGenres = .success(data: data.uniqueByID())
                    } else {
                        self.animeGenres = res
                    }
                }
            } else {
                if case .success = mangaGenres {
                    return
                } else {
                    let res = await FetchHelpers.tryFetch(mangaRepository.getMangaGenres)
                    
                    if case .success(let data) = res {
                        self.mangaGenres = .success(data: data.uniqueByID())
                    } else {
                        self.mangaGenres = res
                    }
                }
            }
        }
    }
    
    func toggleGenre(_ genre: Genre) {
        if let i = selectedGenres.firstIndex(where: { genre.id == $0.id }) {
            selectedGenres.remove(at: i)
        } else {
            selectedGenres.append(genre)
        }
    }
    
    func isGenreSelected(_ genre: Genre) -> Bool {
        selectedGenres.contains(where: { genre.id == $0.id })
    }
    
    func loadMoreMediaResults() {
        if case .success(let prevData) = mediaFetchResults {
            Task {
                if let nextResult {
                    let res = await FetchHelpers.tryFetch {
                        try await nextResult()
                    }
                    
                    if case .success(let data) = res {
                        if let data {
                            self.nextResult = data.next
                            mediaFetchResults = .success(data: (prevData + data.data).uniqueByID())
                        }
                    }
                }
            }
        }
    }
    
    private func updateMediaFetchResults<Media>(
        with operation: () async throws -> PaginatedResult<[Media]>,
        mapper: @escaping ([Media]) -> [MediaCardData]
    ) async {
        nextResult = nil
        
        let res = await FetchHelpers.tryFetch {
            try await operation()
        }
        
        if case .success(let data) = res {
            let mapped = data.mapTo(mapper: mapper)
            nextResult = mapped.next
            mediaFetchResults = .success(data: mapped.data)
        } else if case .failure(let error) = res {
            mediaFetchResults = .failure(error)
        } else {
            mediaFetchResults = .loading
        }
    }
    
    private func animeToMediaCardData(_ data: [AnimeBase]) -> [MediaCardData] {
        data.map { anime in
            anime.toMediaCardData()
        }
    }
    
    private func mangaToMediaCardData(_ data: [MangaBase]) -> [MediaCardData] {
        data.map { manga in
            manga.toMediaCardData()
        }
    }
}
