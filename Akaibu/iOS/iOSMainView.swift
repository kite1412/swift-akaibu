//
//  iOSMainView.swift
//  Akaibu
//
//  Created by kite1412 on 25/12/25.
//

import SwiftUI

struct iOSMainView: View {
    @EnvironmentObject private var router: AppRouter
    
    // Tweak one or more tabs to access unlisted root destinations here.
    var body: some View {
        TabView {
            ForEach(RootDestination.allCases.prefix(4), id: \.self) { des in
                Tab(des.title, systemImage: des.systemImage) {
                    NavigationStack(path: $router.path) {
                        des.content
                            .navigationTitle(des.title)
                            .toolbar {
                                ToolbarItem(placement: .principal) {
                                    TopBar()
                                }
                            }
                            .navigationDestination(for: StackDestination.self) { destination in
                                switch destination {
                                case .mediaSearchResults(let searchTitle):
                                    MediaSearchResultsView(searchTitle: searchTitle)
                                case .animeDetail(let animeId):
                                    AnimeDetailView(animeId: animeId)
                                case .mangaDetail(let mangaId):
                                    MangaDetailView(mangaId: mangaId)
                                case .animeSchedules:
                                    AnimeSchedulesView()
                                }
                            }
                    }
                }
            }
        }
    }
}

#Preview {
    iOSMainView()
}
