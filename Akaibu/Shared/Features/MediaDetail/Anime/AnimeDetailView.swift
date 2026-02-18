//
//  AnimeDetailView.swift
//  Akaibu
//
//  Created by kite1412 on 17/02/26.
//

import SwiftUI

struct AnimeDetailView: View {
    @EnvironmentObject private var appRouter: AppRouter
    @StateObject private var viewModel: AnimeDetailViewModel
    
    init(animeId: Int) {
        _viewModel = StateObject(wrappedValue:  AnimeDetailViewModel(animeId: animeId))
    }
    
    var body: some View {
        MediaDetailView(
            data: viewModel.mediaDetail,
            availableStatuses: UserAnimeStatus.allCases.map(\.rawValue),
            onGoingStatus: UserAnimeStatus.watching.rawValue,
            completedStatus: UserAnimeStatus.completed.rawValue,
            additionalDetails: additionalDetails,
            onUserMediaProgressUpdate: { progress in },
            onMediaClick: appRouter.goToAnimeDetail
        )
    }
    
    private var additionalDetails: [AdditionalDetail] {
        if let anime = viewModel.anime {
            let totalEpisodes = anime.totalEpisodes != nil && anime.totalEpisodes != 0
                ? anime.totalEpisodes.map(String.init) ?? "N/A"
                : "N/A"
            var details: [AdditionalDetail] = [
                AdditionalDetail(
                    title: "Total Episodes",
                    systemImageName: "tv.fill",
                    value: totalEpisodes
                )
            ]
            
            if let startSeason = anime.startSeason {
                details.append(
                    AdditionalDetail(
                        title: "Start Season",
                        systemImageName: "video.badge.waveform.fill",
                        value: startSeason
                    )
                )
            }
            if let startDate = anime.startDate {
                details.append(
                    AdditionalDetail(
                        title: "Start Date",
                        systemImageName: "calendar",
                        value: DateFormatter.asString(from: startDate)
                    )
                )
            }
            if let endDate = anime.endDate {
                details.append(
                    AdditionalDetail(
                        title: "End Date",
                        systemImageName: "calendar.badge.checkmark",
                        value: DateFormatter.asString(from: endDate)
                    )
                )
            }
            
            return details
        } else {
            return []
        }
    }
}

#Preview {
    AnimeDetailView(animeId: 1)
}
