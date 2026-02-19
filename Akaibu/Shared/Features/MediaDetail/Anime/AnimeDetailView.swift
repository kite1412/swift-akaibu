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
    @State private var shake: Bool = false
    
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
            onUserMediaProgressUpdate: viewModel.updateUserAnimeProgress,
            onDeleteFromList: viewModel.deleteUserAnimeProgress,
            onMediaClick: appRouter.goToAnimeDetail,
            otherInformation: otherInformation,
            heroAccessory: { broadcastDate }
        )
    }
    
    @ViewBuilder
    private var broadcastDate: some View {
        if let broadcastDate = viewModel.anime?.broadcastDate, viewModel.anime?.airingStatus == .airing {
            HStack(spacing: 4) {
                Image(systemName: "antenna.radiowaves.left.and.right")
                    .rotationEffect(.degrees(shake ? 8 : -8))
                    .animation(
                        .easeInOut(duration: 0.2)
                        .repeatForever(autoreverses: true),
                        value: shake
                    )
                    .onAppear {
                        shake = true
                    }
                
                Text(broadcastDate)
                    .font(.subheadline)
            }
            .foregroundStyle(.green)
        }
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
    
    private var otherInformation: [String: String] {
        if let anime = viewModel.anime {
            var information: [String: String] = [
                "Rating": anime.rating.rawValue
            ]
            
            if let avgDuration = anime.averageEpisodeDuration {
                information["Average Episode Duration"] = "\(secondsToMinutes(avgDuration)) minutes"
            }
            
            if !anime.studios.isEmpty {
                let studios = anime.studios
                
                information[studios.count == 1 ? "Studio" : "Studios"] = studios.joined(separator: ", ")
            }
            
            return information
        } else {
            return [:]
        }
    }
    
    private func secondsToMinutes(_ second: Int) -> Int {
        return Int((Double(second) / 60).rounded(.toNearestOrAwayFromZero))
    }
}

#Preview {
    AnimeDetailView(animeId: 1)
}
