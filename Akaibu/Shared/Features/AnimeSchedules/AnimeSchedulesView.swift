//
//  AnimeSchedulesView.swift
//  Akaibu
//
//  Created by kite1412 on 21/02/26.
//

import SwiftUI

struct AnimeSchedulesView: View {
    @EnvironmentObject private var appRouter: AppRouter
    @StateObject private var viewModel = AnimeSchedulesViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ItemPicker(
                selected: $viewModel.selectedDayString,
                selections: Day.allCases.map(\.rawValue.capitalized),
                onSelectedChange: viewModel.changeSelectedDay,
                horizontalPadding: 16
            )
            .padding(.vertical, 8)
            
            FetchStateView(
                fetchResult: viewModel.fetchResult,
                loadingText: "Loading schedules...",
                errorText: "Failed to get anime schedules"
            ) { data in
                ScrollViewReader { proxy in
                    ScrollView {
                        ForEach(data.uniqueByID()) { anime in
                            MediaCard(
                                media: anime.toMediaCardData(),
                                onClick: appRouter.goToAnimeDetail
                            ) {
                                let compareResult = anime.day.compare(to: viewModel.selectedDay)
                                
                                HStack(spacing: 4) {
                                    Image(systemName: "calendar.badge.clock")
                                    Text("\(anime.day.rawValue.capitalized) \(anime.time)")
                                }
                                .applyIf(compareResult == 1 || compareResult == -1) { view in
                                    view.foregroundStyle(compareResult == 1 ? .green : .red)
                                }
                            }
                            .id(anime.id)
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                        }
                    }
                    .onChange(of: viewModel.selectedDayString) {
                        DispatchQueue.main.async {
                            if case .success(let data) = viewModel.fetchResult {
                                proxy.scrollTo(data.first?.id ?? 0, anchor: .top)
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

#Preview {
    AnimeSchedulesView()
}
