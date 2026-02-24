//
//  iOSMainView.swift
//  Akaibu
//
//  Created by kite1412 on 25/12/25.
//

#if os(iOS)
import SwiftUI

struct iOSMainView: View {
    @EnvironmentObject private var appRouter: AppRouter
    
    @ObservedObject var session: SessionManager
    @State private var showLogoutConfirmation: Bool = false
    
    // Tweak one or more tabs to access unlisted root destinations here.
    var body: some View {
        TabView {
            ForEach(RootDestination.allCases.prefix(4), id: \.self) { des in
                Tab(des.title, systemImage: des.systemImage) {
                    NavigationStack(path: $appRouter.path) {
                        des.content
                            .navigationTitle(des.title)
                            .toolbar {
                                ToolbarItem(placement: .principal) {
                                    TopBar()
                                }
                                ToolbarItem(placement: .topBarTrailing) {
                                    Button {
                                        showLogoutConfirmation = true
                                    } label: {
                                        Image(systemName: "rectangle.portrait.and.arrow.right")
                                            .foregroundStyle(.red)
                                    }
                                }
                            }
                            .logoutAlert(showAlert: $showLogoutConfirmation) {
                                session.logout()
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
                                case .animeRanking:
                                    MediaRankingView(
                                        mediaType: "Anime",
                                        service: AnimeRankingService(),
                                        onMediaClick: appRouter.goToAnimeDetail
                                    )
                                case .mangaRanking:
                                    MediaRankingView(
                                        mediaType: "Manga",
                                        service: MangaRankingService(),
                                        onMediaClick: appRouter.goToMangaDetail
                                    )
                                }
                            }
                    }
                }
            }
        }
    }
}

#Preview {
    iOSMainView(session: SessionManager())
}
#endif
