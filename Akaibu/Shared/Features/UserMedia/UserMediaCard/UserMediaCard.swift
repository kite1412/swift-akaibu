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
    let onConsumedUnitsUpdate: (Int) -> Void
    let onScoreUpdate: (Int) -> Void
    let onStatusUpdate: (String) -> Void
    
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
        self.onConsumedUnitsUpdate = onConsumedUnitsUpdate
        self.onStatusUpdate = onStatusUpdate
    }
    
    var body: some View {
        MediaCard(media: data.toMediaCardData()) {
            VStack(alignment: .leading, spacing: 4) {
                MediaProgress(
                    data: UserMediaProgress(
                        status: data.userMediaProgress.status,
                        score: data.userMediaProgress.score,
                        consumedUnits: data.userMediaProgress.consumedUnits,
                        updatedAt: data.userMediaProgress.updatedAt
                    ),
                    totalUnits: data.totalUnits,
                    availableStatuses: availableStatuses,
                    completedStatus: completedStatus,
                    onStatusUpdate: onStatusUpdate,
                    onScoreUpdate: onScoreUpdate,
                    onConsumedUnitsUpdate: onConsumedUnitsUpdate
                )
            }
        }
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
    userMediaProgress: UserMediaProgress(
        status: "Watching",
        score: 10,
        consumedUnits: 8,
        updatedAt: Date()
    )
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
    userMediaProgress: UserMediaProgress(
        status: "Watching",
        score: 10,
        consumedUnits: 8,
        updatedAt: Date()
    )
)

#Preview {
    @Previewable @State var mediaCardDataList = [userMediaData, userMediaDataMinimum]
    
    List(Array(mediaCardDataList.enumerated()), id: \.element.id) { index, media in
        UserMediaCard(
            data: media,
            availableStatuses: ["Watching", "Completed", "Plan To Watch"],
            completedStatus: "Completed",
            onConsumedUnitsUpdate: { newConsumedUnits in
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
                    userMediaProgress: UserMediaProgress(
                        status: "Watching",
                        score: 10,
                        consumedUnits: newConsumedUnits,
                        updatedAt: Date()
                    )
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
                    userMediaProgress: UserMediaProgress(
                        status: "Watching",
                        score: newScore,
                        consumedUnits: 8,
                        updatedAt: Date()
                    )
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
                    userMediaProgress: UserMediaProgress(
                        status: newStatus,
                        score: 10,
                        consumedUnits: 8,
                        updatedAt: Date()
                    )
                )
            }
        )
    }
    .listStyle(.plain)
}
