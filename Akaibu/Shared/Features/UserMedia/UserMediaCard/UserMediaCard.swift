//
//  UserMediaCard.swift
//  Akaibu
//
//  Created by kite1412 on 03/01/26.
//

import SwiftUI

struct UserMediaCard: View {
    let data: UserMediaData
    let availableStatuses: [String]
    let completedStatus: String
    let onProgressUpdate: (Int) -> Void
    let onScoreUpdate: (Int) -> Void
    let onStatusUpdate: (String) -> Void
    
    @State private var consumedUnits: String = ""
    @State private var score: String = ""
    @State private var consumedUnitsPopover: Bool = false
    @State private var scorePopover: Bool = false
    @State private var statusPopover: Bool = false
    
    init(
        data: UserMediaData,
        availableStatuses: [String],
        completedStatus: String,
        onConsumedUnitsUpdate: @escaping (Int) -> Void,
        onScoreUpdate: @escaping (Int) -> Void,
        onStatusUpdate: @escaping (String) -> Void
    ) {
        self.data = data
        self.completedStatus = completedStatus
        
        if data.totalUnits == nil {
            self.availableStatuses = availableStatuses.filter { $0 != completedStatus }
        } else {
            self.availableStatuses = availableStatuses
        }
        
        self.onScoreUpdate = onScoreUpdate
        self.onProgressUpdate = onConsumedUnitsUpdate
        self.onStatusUpdate = onStatusUpdate
        _consumedUnits = State(initialValue: String(data.consumedUnits))
        _score = State(initialValue: String(data.userScore))
    }
    
    var body: some View {
        MediaCard(media: data.toMediaCardData()) {
            VStack(alignment: .leading, spacing: 4) {
                editableProp(
                    label: "Status",
                    value: data.userStatus,
                    systemImage: nil,
                    showPopover: $statusPopover
                )
                .popover(isPresented: $statusPopover, arrowEdge: .bottom) {
                    popoverContent {
                        VStack {
                            ForEach(availableStatuses, id: \.self) { status in
                                VStack(spacing: 4) {
                                    Text(status)
                                    Divider()
                                }
                                .onTapGesture {
                                    statusPopover = false
                                    onStatusUpdate(status)
                                }
                                .foregroundStyle(data.userStatus == status ? .accent : .primary)
                            }
                        }
                    }
                }
                
                HStack {
                    editableProp(
                        label: "Progress",
                        value: "\(data.consumedUnits) / \(data.totalUnits.map { String($0) } ?? "*")",
                        systemImage: "chevron.down",
                        showPopover: $consumedUnitsPopover
                    )
                    .popover(isPresented: $consumedUnitsPopover, arrowEdge: .bottom) {
                        popoverContent {
                            editField(
                                label: "Progress",
                                value: $consumedUnits,
                                trailing: "/ \(data.totalUnits.map(\.description) ?? "*")"
                            ) { newValue in
                                consumedUnitsPopover = false
                                if let newProgress = Int(newValue) {
                                    onProgressUpdate(newProgress)
                                }
                            }
                            .onChange(of: consumedUnits) {
                                if let consumedUnits = Int(consumedUnits) {
                                    self.consumedUnits = String(
                                        intThreshold(
                                            actualValue: consumedUnits,
                                            maxValue: data.totalUnits ?? Int.max
                                        )
                                    )
                                }
                            }
                        }
                    }
                    .onChange(of: consumedUnitsPopover) {
                        if consumedUnitsPopover {
                            consumedUnits = String(data.consumedUnits)
                        }
                    }
                    
                    editableProp(
                        label: "Score",
                        value: String(data.userScore),
                        systemImage: "star.fill",
                        showPopover: $scorePopover
                    )
                    .popover(isPresented: $scorePopover, arrowEdge: .bottom) {
                        popoverContent {
                            editField(
                                label: "Score",
                                value: $score,
                                trailing: "/ 10"
                            ) { newValue in
                                scorePopover = false
                                onScoreUpdate(Int(newValue) ?? 0)
                            }
                            .onChange(of: score) {
                                if let score = Int(score) {
                                    self.score = String(intThreshold(actualValue: score, maxValue: 10))
                                }
                            }
                        }
                    }
                    .onChange(of: scorePopover) {
                        if scorePopover {
                            score = String(data.userScore)
                        }
                    }
                }
            }
            .padding(.top, 8)
        }
    }
    
    private func intThreshold(actualValue: Int, maxValue: Int) -> Int {
        min(actualValue >= 0 ? actualValue : 0, maxValue)
    }
    
    private func editableProp(
        label: String,
        value: String,
        systemImage: String?,
        showPopover: Binding<Bool>
    ) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .foregroundStyle(.secondary)
            HStack {
                Text(value)
                if let systemImage {
                    Image(systemName: systemImage)
                        .foregroundStyle(.accent)
                }
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(.gray.opacity(0.2))
            )
        }
        .font(.caption)
        .onTapGesture {
            showPopover.wrappedValue.toggle()
        }
    }
    
    private func popoverContent(_ content: () -> some View) -> some View {
        content()
            .padding(8)
            .presentationCompactAdaptation(.popover)
    }
    
    private func editField(
        label: String,
        value: Binding<String>,
        trailing: String,
        onConfirm: @escaping (String) -> Void
    ) -> some View {
        VStack(spacing: 4) {
            Text(label)
                .foregroundStyle(.secondary)
            HStack(spacing: 0) {
                TextField("", text: value)
                    #if os(iOS)
                    .keyboardType(.numberPad)
                    #endif
                    .textFieldStyle(.roundedBorder)
                    .onSubmit {
                        onConfirm(value.wrappedValue)
                    }
                Text(" \(trailing)")
                    .foregroundStyle(.secondary)
            }
            .frame(minWidth: 60)
        }
        .font(.subheadline)
    }
}

// TODO delete later
let userMediaData = UserMediaData(
    id: 1,
    title: "A title",
    synopsis: "Synopsis",
    coverImageUrl: URL.init(string: "https://picsum.photos/300/200"),
    isAdult: true,
    score: 9.8,
    scoringUsers: 20000,
    genres: ["Fantasy", "Drama", "Action"],
    status: "Completed",
    type: "TV",
    totalUnits: 12,
    userStatus: "Watching",
    userScore: 10,
    consumedUnits: 8,
    updatedAt: Date()
)

let userMediaDataMinimum = UserMediaData(
    id: 2,
    title: "A title",
    synopsis: nil,
    coverImageUrl: nil,
    isAdult: false,
    score: nil,
    scoringUsers: nil,
    genres: ["Fantasy", "Drama", "Action"],
    status: "Completed",
    type: "TV",
    totalUnits: 12,
    userStatus: "Watching",
    userScore: 0,
    consumedUnits: 8,
    updatedAt: Date()
)

#Preview {
    @Previewable @State var mediaCardDataList = [userMediaData, userMediaDataMinimum]
    
    List(Array(mediaCardDataList.enumerated()), id: \.element.id) { index, media in
        UserMediaCard(
            data: media,
            availableStatuses: ["Watching", "Completed", "Plan To Watch"],
            completedStatus: "Completed",
            onConsumedUnitsUpdate: { newProgress in
                mediaCardDataList[index] = UserMediaData(
                    id: media.id,
                    title: media.title,
                    synopsis: media.synopsis,
                    coverImageUrl: media.coverImageUrl,
                    isAdult: media.isAdult,
                    score: media.score,
                    scoringUsers: media.scoringUsers,
                    genres: media.genres,
                    status: media.status,
                    type: media.type,
                    totalUnits: media.totalUnits,
                    userStatus: media.userStatus,
                    userScore: media.userScore,
                    consumedUnits: newProgress,
                    updatedAt: media.updatedAt
                )
            },
            onScoreUpdate: { newScore in
                mediaCardDataList[index] = UserMediaData(
                    id: media.id,
                    title: media.title,
                    synopsis: media.synopsis,
                    coverImageUrl: media.coverImageUrl,
                    isAdult: media.isAdult,
                    score: media.score,
                    scoringUsers: media.scoringUsers,
                    genres: media.genres,
                    status: media.status,
                    type: media.type,
                    totalUnits: media.totalUnits,
                    userStatus: media.userStatus,
                    userScore: newScore,
                    consumedUnits: media.consumedUnits,
                    updatedAt: media.updatedAt
                )
            },
            onStatusUpdate: { newStatus in
                mediaCardDataList[index] = UserMediaData(
                    id: media.id,
                    title: media.title,
                    synopsis: media.synopsis,
                    coverImageUrl: media.coverImageUrl,
                    isAdult: media.isAdult,
                    score: media.score,
                    scoringUsers: media.scoringUsers,
                    genres: media.genres,
                    status: media.status,
                    type: media.type,
                    totalUnits: media.totalUnits,
                    userStatus: newStatus,
                    userScore: media.userScore,
                    consumedUnits: media.consumedUnits,
                    updatedAt: media.updatedAt
                )
            }
        )
    }
    .listStyle(.plain)
}
