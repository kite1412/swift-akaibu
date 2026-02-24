//
//  macOSMainView.swift
//  Akaibu
//
//  Created by kite1412 on 25/12/25.
//

#if os(macOS)
import SwiftUI

struct macOSMainView: View {
    @EnvironmentObject private var appRouter: AppRouter
    private let animation: Animation = .easeInOut(duration: 0.3)
    
    @Binding var currentDestination: RootDestination
    @ObservedObject var session: SessionManager
    @State private var showLogoutConfirmation: Bool = false
    
    var body: some View {
        NavigationSplitView {
            VStack {
                TopBar()
                List(
                    RootDestination.allCases,
                    id: \.self
                ) { des in
                    let foregroundStyle = currentDestination == des ? Color.white : Color.primary
                    
                    Button {
                        currentDestination = des
                    } label: {
                        Label {
                            Text(des.title)
                        } icon: {
                            Image(systemName: des.systemImage)
                                .foregroundStyle(foregroundStyle)
                        }
                        .foregroundStyle(foregroundStyle)
                        .animation(animation, value: currentDestination)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(currentDestination == des ? Colors.accent : .clear)
                            .animation(animation, value: currentDestination)
                    )
                }
                
                Spacer()
                
                Button("Logout", systemImage: "rectangle.portrait.and.arrow.forward") {
                    showLogoutConfirmation = true
                }
                .frame(maxWidth: .infinity)
                .buttonSizing(.flexible)
                .padding()
                .foregroundStyle(.red)
            }
        } detail: {
            NavigationStack(path: $appRouter.path) {
                currentDestination.content
                    .navigationDestination(for: StackDestination.self) { destination in
                        switch destination {
                        case .mediaSearchResults(let searchTitle):
                            MediaSearchResultsView(searchTitle: searchTitle)
                        case .animeDetail(let animeId):
                            AnimeDetailView(animeId: animeId)
                        case .mangaDetail(let mangaId):
                            MangaDetailView(mangaId: mangaId)
                        case .animeSchedules:
                            VStack {}
                                .onAppear {
                                    currentDestination = .animeSchedules
                                    appRouter.pop()
                                }
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
        .navigationTitle(currentDestination.title)
        .logoutAlert(showAlert: $showLogoutConfirmation) {
            session.logout()
        }
    }
}

#Preview {
    @Previewable @State var des: RootDestination = .home
    
    macOSMainView(currentDestination: $des, session: SessionManager())
}
#endif
