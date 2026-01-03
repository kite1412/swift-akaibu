//
//  UserMediaCard.swift
//  Akaibu
//
//  Created by kite1412 on 03/01/26.
//

import SwiftUI

struct UserMediaCard: View {
    let data: UserMediaData
    let onProgressUpdate: (Int) -> Void
    let onScoreUpdate: (Int) -> Void
    
    @State private var proggres: String = ""
    @State private var score: String = ""
    @State private var progressPopover: Bool = false
    @State private var scorePopover: Bool = false
    
    init(
        data: UserMediaData,
        onProgressUpdate: @escaping (Int) -> Void,
        onScoreUpdate: @escaping (Int) -> Void
    ) {
        self.data = data
        self.onScoreUpdate = onScoreUpdate
        self.onProgressUpdate = onProgressUpdate
        _proggres = State(initialValue: String(data.consumedUnits))
        _score = State(initialValue: String(data.userScore))
    }
    
    var body: some View {
        MediaCard(media: data.toMediaCardData()) {
            HStack {
                editableProp(
                    label: "Progress",
                    value: "\(data.consumedUnits) / \(data.totalUnits.map { String($0) } ?? "*")",
                    systemImage: "chevron.down",
                    showPopover: $progressPopover
                )
                .popover(isPresented: $progressPopover, arrowEdge: .bottom) {
                    popoverContent {
                        editField(
                            label: "Progress",
                            value: $proggres,
                            trailing: "/ \(data.totalUnits.map(\.description) ?? "*")"
                        ) { newValue in
                            progressPopover = false
                            onProgressUpdate(Int(newValue) ?? 0)
                        }
                    }
                }
                .onChange(of: progressPopover) {
                    if progressPopover {
                        proggres = String(data.consumedUnits)
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
                    }
                }
                .onChange(of: scorePopover) {
                    if scorePopover {
                        score = String(data.userScore)
                    }
                }
            }
            .padding(.top, 8)
        }
    }
    
    private func editableProp(
        label: String,
        value: String,
        systemImage: String,
        showPopover: Binding<Bool>
    ) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .foregroundStyle(.secondary)
            HStack {
                Text(value)
                Image(systemName: systemImage)
                    .foregroundStyle(.accent)
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
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit {
                        onConfirm(value.wrappedValue)
                    }
                Text(" \(trailing)")
                    .foregroundStyle(.secondary)
            }
        }
        .font(.subheadline)
    }
}

private let data = UserMediaData(
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
    userStatus: "Watching",
    userScore: 10,
    consumedUnits: 8,
    totalUnits: 12
)

private let dataMinimum = UserMediaData(
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
    userStatus: "Watching",
    userScore: 0,
    consumedUnits: 8,
    totalUnits: 12
)

#Preview {
    @Previewable @State var mediaCardDataList = [data, dataMinimum]
    
    List(Array(mediaCardDataList.enumerated()), id: \.element.id) { index, media in
        UserMediaCard(
            data: media,
            onProgressUpdate: { newProgress in
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
                    userStatus: media.userStatus,
                    userScore: media.userScore,
                    consumedUnits: newProgress,
                    totalUnits: media.totalUnits
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
                    userStatus: media.userStatus,
                    userScore: newScore,
                    consumedUnits: media.consumedUnits,
                    totalUnits: media.totalUnits
                )
            }
        )
    }
    .listStyle(.plain)
}
