//
//  MangaDetailView.swift
//  Akaibu
//
//  Created by kite1412 on 18/02/26.
//

import SwiftUI

struct MangaDetailView: View {
    @EnvironmentObject private var appRouter: AppRouter
    @StateObject private var viewModel: MangaDetailViewModel
    
    init(mangaId: Int) {
        _viewModel = StateObject(wrappedValue: MangaDetailViewModel(mangaId: mangaId))
    }
    
    var body: some View {
        MediaDetailView(
            data: viewModel.mediaDetail,
            availableStatuses: UserMangaStatus.allCases.map(\.rawValue),
            onGoingStatus: UserMangaStatus.reading.rawValue,
            completedStatus: UserMangaStatus.completed.rawValue,
            additionalDetails: additionalDetails,
            onUserMediaProgressUpdate: viewModel.updateUserMangaProgress,
            onDeleteFromList: {},
            onMediaClick: appRouter.goToMangaDetail
        )
    }
    
    private var additionalDetails: [AdditionalDetail] {
        if let manga = viewModel.manga {
            let totalChapters = manga.totalChapters != nil && manga.totalChapters != 0
                ? manga.totalChapters.map(String.init) ?? "N/A"
                : "N/A"
            
            let totalVolumes = manga.totalVolumes != nil && manga.totalVolumes != 0
                ? manga.totalVolumes.map(String.init) ?? "N/A"
                : "N/A"
            
            var details: [AdditionalDetail] = [
                AdditionalDetail(
                    title: "Total Chapters",
                    systemImageName: "book.fill",
                    value: totalChapters
                ),
                AdditionalDetail(
                    title: "Total Volumes",
                    systemImageName: "book.closed.fill",
                    value: totalVolumes
                )
            ]
            
            if let startDate = manga.startDate {
                details.append(
                    AdditionalDetail(
                        title: "Start Date",
                        systemImageName: "calendar",
                        value: DateFormatter.asString(from: startDate)
                    )
                )
            }
            if let endDate = manga.endDate {
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
    MangaDetailView(mangaId: 1)
}
