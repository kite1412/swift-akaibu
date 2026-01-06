//
//  UserMediaView.swift
//  Akaibu
//
//  Created by kite1412 on 03/01/26.
//

import SwiftUI

struct UserMediaView: View {
    let statuses: [String]
    let completedStatus: String
    
    @StateObject private var viewModel: UserMediaViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    ForEach(statuses, id: \.self) { status in
                        let selected = viewModel.selectedStatus == status
                        
                        Text(status).tag(status)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 50)
                                    .fill(selected ? .accent : .clear)
                            )
                            .animation(.easeInOut(duration: 0.3), value: selected)
                            .foregroundStyle(
                                selected ? .white : .primary
                            )
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    viewModel.selectedStatus = status
                                }
                            }
                    }
                }
                .onChange(of: viewModel.selectedStatus) { _, newStatus in
                    viewModel.changeSelectedStatus(newStatus)
                }
                .padding(4)
                .background(
                    RoundedRectangle(cornerRadius: 50)
                        .fill(.thinMaterial)
                )
                .padding(.leading)
                .padding(.top)
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(
                id: Binding<String?>(
                    get: { viewModel.selectedStatus },
                    set: { viewModel.selectedStatus = $0 ?? viewModel.selectedStatus }
                )
            )
            .scrollIndicators(.hidden)
            
            ZStack {
                switch viewModel.uiState {
                case .loading:
                    Loading(loadingText: "Loading list...")
                case .success:
                    if !viewModel.filteredUserMediaList.isEmpty {
                        ScrollView {
                            VStack(alignment: .leading) {
                                ForEach(viewModel.filteredUserMediaList) { media in
                                    UserMediaCard(
                                        data: media,
                                        availableStatuses: statuses.filter { status in
                                            status != "All"
                                        }
                                    ) { newConsumedUnits in
                                        viewModel.updateMediaConsumedUnits(for: media, consumedUnits: newConsumedUnits)
                                    } onScoreUpdate: { newScore in
                                        viewModel.updateMediaScore(for: media, score: newScore)
                                    } onStatusUpdate: { newStatus in
                                        viewModel.updateMediaStatus(for: media, status: newStatus)
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                        }
                    } else {
                        VStack {
                            Image(systemName: "text.page.slash")
                            Text("list is empty")
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .font(.title)
                        .foregroundStyle(.secondary)
                    }
                case .failure:
                    Text("Failed to load the list. Please try again later.")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    init(statuses: [String], completedStatus: String, service: UserMediaService) {
        _viewModel = StateObject(wrappedValue: UserMediaViewModel(service: service))
        self.statuses = ["All"] + statuses
        if statuses.contains(where: { completedStatus == $0 }) {
            self.completedStatus = completedStatus
        } else {
            fatalError(".completedStatus is not present in .statuses")
        }
    }
}

#Preview {
    UserMediaView(
        statuses: ["Watching", "On Hold", "Completed", "Another", "Another Another"], 
        completedStatus: "Completed",
        service: MockUserMediaService()
    )
}
