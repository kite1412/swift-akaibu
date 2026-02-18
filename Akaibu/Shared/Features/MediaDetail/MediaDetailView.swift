//
//  MediaDetailView.swift
//  Akaibu
//
//  Created by kite1412 on 14/02/26.
//

import SwiftUI
import Foundation

struct MediaDetailView: View {
    let data: MediaDetailData?
    let availableStatuses: [String]
    let onGoingStatus: String
    let completedStatus: String
    var additionalDetails: [AdditionalDetail]
    let onUserMediaProgressUpdate: (UserMediaProgress) -> Void
    
    @State private var isSynopsisExpanded: Bool = false
    @State private var showAddToListForm: Bool = false
    @State private var userProgress: UserMediaProgress = UserMediaProgress(
        status: "",
        score: 0,
        consumedUnits: 0,
        updatedAt: Date()
    )
    
    private let synopsisLimit: Int = 200
    private var isSynopsisExceedingLimit: Bool {
        data?.synopsis.map { $0.count > synopsisLimit } ?? false
    }
    
    init(
        data: MediaDetailData?,
        availableStatuses: [String],
        onGoingStatus: String,
        completedStatus: String,
        additionalDetails: [AdditionalDetail],
        onUserMediaProgressUpdate: @escaping (UserMediaProgress) -> Void
    ) {
        self.data = data
        self.availableStatuses = availableStatuses
        self.onGoingStatus = onGoingStatus
        self.completedStatus = completedStatus
        self.additionalDetails = additionalDetails
        self.onUserMediaProgressUpdate = onUserMediaProgressUpdate
        _userProgress = State(
            initialValue: defaultUserMediaProgress()
        )
    }
    
    var body: some View {
        if let data {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(alignment: .top) {
                            BrowseImage(data.coverImageURL)
                                .aspectRatio(2/3, contentMode: .fit)
                                .frame(maxHeight: 240)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                            
                            VStack(alignment: .leading, spacing: 16) {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(data.title)
                                        .lineLimit(3)
                                        .truncationMode(.middle)
                                        .font(.title)
                                    
                                    score
                                    genres
                                    alternativeTitles
                                }
                                
                                HStack(spacing: 4) {
                                    MediaLabel(data.type, kind: .type)
                                    MediaLabel(data.status, kind: .status)
                                    
                                    if data.isAdult {
                                        MediaLabel("18+", kind: .adult)
                                    }
                                }
                                .font(.caption)
                            }
                            .padding(4)
                        }
                        
                        if let _ = data.userProgress {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("My Progress")
                                    .font(.headline)
                                
                                HStack {
                                    MediaProgress(
                                        data: userProgress,
                                        totalUnits: data.totalUnits,
                                        availableStatuses: availableStatuses,
                                        completedStatus: completedStatus,
                                        onUserMediaProgressUpdate: onUserMediaProgressUpdate
                                    )
                                }
                            }
                        }
                    }
                    
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ],
                        alignment: .leading,
                        spacing: 16
                    ) {
                        rank
                        ForEach(additionalDetails, id: \.title) { detail in
                            detailRow(
                                systemImageName: detail.systemImageName,
                                label: detail.value,
                                title: detail.title
                            )
                        }
                    }
                    .padding(16)
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    if let synopsis = data.synopsis {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Synopsis")
                                .foregroundStyle(.primary)
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text(
                                isSynopsisExceedingLimit ? isSynopsisExpanded ?
                                    synopsis
                                    : synopsis.truncated(to: synopsisLimit, trailing: "...")
                                    : synopsis
                            )
                            
                            if isSynopsisExceedingLimit {
                                Image(systemName: "chevron.down")
                                    .rotationEffect(Angle(degrees: isSynopsisExpanded ? 180 : 0))
                                    .frame(maxWidth: .infinity)
                                    .foregroundStyle(.accent)
                            }
                        }
                        .font(.subheadline)
                        .padding(8)
                        .background(.thinMaterial)
                        .foregroundStyle(.secondary)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .animation(.easeInOut, value: isSynopsisExpanded)
                        .onTapGesture {
                            if isSynopsisExceedingLimit {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    isSynopsisExpanded.toggle()
                                }
                            }
                        }
                    }
                    
                    if !data.recommendations.isEmpty {
                        let recommendations = data.recommendations
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Recommendations")
                                .font(.headline)
                            
                            ScrollView(.horizontal) {
                                LazyHStack {
                                    ForEach(recommendations, id: \.id) { media in
                                        SmallMediaCard(
                                            data: media.toSmallMediaCardData(description: "Votes: \(media.totalVotes)")
                                        )
                                    }
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Detail")
                .toolbar {
                    if data.userProgress == nil {
                        ToolbarItem {
                            Text("Add to list")
                                .foregroundStyle(.accent)
                                .onTapGesture {
                                    showAddToListForm.toggle()
                                }
                        }
                    }
                }
            }
            .padding()
            .overlay {
                if showAddToListForm {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                    
                    VStack(alignment: .leading, spacing: 16) {
                        VStack(alignment: .leading, spacing: 8) {
                            MediaProgress(
                                data: userProgress,
                                totalUnits: data.totalUnits,
                                availableStatuses: availableStatuses,
                                completedStatus: completedStatus,
                                onUserMediaProgressUpdate: { progress in
                                    userProgress = progress
                                }
                            )
                        }
                        
                        HStack {
                            Button("Cancel") {
                                showAddToListForm = false
                                userProgress = defaultUserMediaProgress()
                            }
                            .foregroundStyle(.primary)
                            .buttonStyle(.glass)
                            
                            Spacer()
                            
                            Button("Add") {
                                showAddToListForm = false
                            }
                            .foregroundStyle(.accent)
                            .buttonStyle(.glass)
                        }
                    }
                    .frame(maxWidth: 240, alignment: .leading)
                    .padding(16)
                    .background(.background)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
            .onAppear {
                if let userProgress = data.userProgress {
                    self.userProgress = userProgress
                }
            }
        } else {
            Loading(loadingText: "Loading Details...")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .navigationTitle("Detail")
        }
    }
    
    private var score: some View {
        HStack(spacing: 16) {
            detailRow(
                systemImageName: "star.fill",
                label: data?.score.map { String(format: "%.2f", $0) } ?? "N/A",
                imageStyle: .yellow,
                textStyle: .primary
            )
            
            if let scoringUsers = data?.scoringUsers {
                detailRow(
                    systemImageName: "person.2.fill",
                    label: scoringUsers,
                    imageStyle: .gray,
                    textStyle: .primary
                )
            }
        }
        .italic()
        .font(.caption)
    }
    
    @ViewBuilder
    private var genres: some View {
        if let genres = data?.genres {
            Text(genres.joined(separator: " · "))
                .font(.caption2)
                .foregroundStyle(.secondary)
                .italic()
        }
    }
    
    @ViewBuilder
    private var alternativeTitles: some View {
        if let data {
            if !data.alternativeTitles.isEmpty {
                Text("Title: \(data.alternativeTitles.joined(separator: ", "))")
                    .italic()
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
    
    @ViewBuilder
    private var rank: some View {
        if let data {
            let systemName = "number"
            
            if let rank = data.rank {
                detailRow(systemImageName: systemName, label: rank, title: "Rank")
            } else {
                detailRow(systemImageName: systemName, label: "Not Ranked")
            }
        }
    }
    
    private func detailRow(
        systemImageName: String,
        label: String,
        title: String? = nil,
        imageStyle: some ShapeStyle = .secondary,
        textStyle: some ShapeStyle = .secondary
    ) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            if let title {
                Text(title)
                    .bold()
                    .foregroundStyle(textStyle)
            }
            
            HStack(spacing: 4) {
                Image(systemName: systemImageName)
                    .foregroundStyle(imageStyle)
                
                Text(label)
                    .foregroundStyle(textStyle)
            }
        }
    }
    
    private func detailRow(
        systemImageName: String,
        label: Int,
        title: String? = nil,
        imageStyle: some ShapeStyle = .secondary,
        textStyle: some ShapeStyle = .secondary
    ) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            if let title {
                Text(title)
                    .bold()
                    .foregroundStyle(textStyle)
            }
            
            HStack(spacing: 4) {
                Image(systemName: systemImageName)
                    .foregroundStyle(imageStyle)
                
                Text(label, format: .number.locale(Locale(identifier: "en_US")))
                    .foregroundStyle(textStyle)
            }
        }
    }
    
    private func defaultUserMediaProgress() -> UserMediaProgress {
        UserMediaProgress(
            status: onGoingStatus,
            score: 0,
            consumedUnits: 0,
            updatedAt: Date()
        )
    }
}

private let data = MediaDetailData(
    title: "A very long long long long long long long long title",
    synopsis: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
        + "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. "
        + "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. "
        + "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    coverImageURL: URL(string: "https://picsum.photos/300/200"),
    type: "A type",
    status: "Completed",
    isAdult: true,
    genres: ["genre 1", "genre 2", "genre 3", "genre 4", "genre 5"],
    score: 8,
    scoringUsers: 10000,
    alternativeTitles: ["A title", "Another title"],
    rank: 1000,
    totalUnits: 12,
    userProgress: UserMediaProgress(
        status: "Completed",
        score: 8,
        consumedUnits: 10,
        updatedAt: Date()
    ),
//    userProgress: nil
    recommendations: []
)

#Preview {
    NavigationStack {
        MediaDetailView(
            data: data,
            availableStatuses: ["Watching", "Completed", "Dropped"],
            onGoingStatus: "Watching",
            completedStatus: "Completed",
            additionalDetails: [
                AdditionalDetail(title: "Total Episodes", systemImageName: "tv", value: "12"),
                AdditionalDetail(title: "A Detail", systemImageName: "tv", value: "A detail value"),
                AdditionalDetail(title: "Another Detail", systemImageName: "tv", value: "A detail value")
            ],
            onUserMediaProgressUpdate: { progress in }
        )
    }
}
