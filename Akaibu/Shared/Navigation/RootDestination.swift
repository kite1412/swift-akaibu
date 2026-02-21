//
//  RootDestination.swift
//  Akaibu
//
//  Created by kite1412 on 25/12/25.
//

import SwiftUI

enum RootDestination: CaseIterable {
    case home
    case myAnime
    case myManga
    case genres
    case animeSchedules
    
    var systemImage: String {
        switch self {
        case .home: return "house"
        case .myAnime: return "tv"
        case .myManga: return "book.pages"
        case .genres: return "rectangle.grid.2x2"
        case .animeSchedules: return "calendar"
        }
    }
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .myAnime: return "My Anime"
        case .myManga: return "My Manga"
        case .genres: return "Genres"
        case .animeSchedules: return "Anime Schedules"
        }
    }
    
    @ViewBuilder
    var content: some View {
        switch self {
        case .home: HomeView()
        case .myAnime: UserMediaView(
            statuses: UserAnimeStatus.allCases.map(\.rawValue),
            completedStatus: UserAnimeStatus.completed.rawValue,
            service: AnimeUserMediaService()
        )
        case .myManga: UserMediaView(
            statuses: UserMangaStatus.allCases.map(\.rawValue),
            completedStatus: UserMangaStatus.completed.rawValue,
            service: MangaUserMediaService()
        )
        case .genres: MediaGenresView()
        case .animeSchedules: AnimeSchedulesView()
        }
    }
}
