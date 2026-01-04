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
    
    @StateObject private var viewModel = UserMediaViewModel()
    
    init(statuses: [String], completedStatus: String) {
        self.statuses = ["All"] + statuses
        if statuses.contains(where: { completedStatus == $0 }) {
            self.completedStatus = completedStatus
        } else {
            fatalError(".completedStatus is not present in .statuses")
        }
    }
    
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
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(
                id: Binding<String?>(
                    get: { viewModel.selectedStatus },
                    set: { viewModel.selectedStatus = $0 ?? viewModel.selectedStatus }
                )
            )
            .scrollIndicators(.hidden)
            
            if !viewModel.filteredUserMediaList.isEmpty {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(viewModel.filteredUserMediaList) { media in
                            UserMediaCard(data: media) { newConsumedUnits in
                                
                            } onScoreUpdate: { newScore in
                                
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
        }
    }
}

#Preview {
    UserMediaView(
        statuses: ["Watching", "On Hold", "Completed", "Another", "Another Another"], completedStatus: "Completed"
    )
}
