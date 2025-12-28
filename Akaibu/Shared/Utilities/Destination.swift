//
//  Destination.swift
//  Akaibu
//
//  Created by kite1412 on 25/12/25.
//

import SwiftUI

enum Destination: CaseIterable {
    case home
    case myAnime
    case myManga
    case categories
    case seasonalAnime
    
    var systemImage: String {
        switch self {
        case .home: return "house"
        case .myAnime: return "tv"
        case .myManga: return "book.pages"
        case .categories: return "rectangle.grid.2x2"
        case .seasonalAnime: return "calendar"
        }
    }
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .myAnime: return "My Anime"
        case .myManga: return "My Manga"
        case .categories: return "Categories"
        case .seasonalAnime: return "Seasonal Anime"
        }
    }
    
    @ViewBuilder
    var content: some View {
        switch self {
        case .home: Text("Home")
        case .myAnime: Text("My Anime")
        case .myManga: Text("My Manga")
        case .categories: Text("Categories")
        case .seasonalAnime: Text("Seasonal Anime")
        }
    }
}
