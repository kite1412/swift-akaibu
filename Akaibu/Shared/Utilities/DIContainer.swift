//
//  DIContainer.swift
//  Akaibu
//
//  Created by kite1412 on 28/12/25.
//

struct DIContainer {
    static let shared = DIContainer()
    
    // Remote Data Sources
    let authRemoteDataSource: AuthRemoteDataSource
    let animeRemoteDataSource: AnimeRemoteDataSource
    let mangaRemoteDataSource: MangaRemoteDataSource
    
    // Repositories
    let animeRepository: AnimeRepository
    let mangaRepository: MangaRepository
    
    private init() {
        authRemoteDataSource = MALAuthDataSource()
        animeRemoteDataSource = MALAnimeDataSource()
        mangaRemoteDataSource = MALMangaDataSource()
        animeRepository = AnimeRepositoryImpl(remoteDataSource: animeRemoteDataSource)
        mangaRepository = MangaRepositoryImpl(remoteDataSource: mangaRemoteDataSource)
    }
}
