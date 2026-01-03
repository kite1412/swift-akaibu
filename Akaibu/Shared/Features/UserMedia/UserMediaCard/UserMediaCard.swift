//
//  UserMediaCard.swift
//  Akaibu
//
//  Created by kite1412 on 03/01/26.
//

import SwiftUI

struct UserMediaCard: View {
    let data: UserMediaData
    
    var body: some View {
        MediaCard(media: data.toMediaCardData()) {
            HStack {
                editField(
                    label: "Progress",
                    value: "\(data.consumedUnits) / \(data.totalUnits.map { String($0) } ?? "*")",
                    systemImage: "chevron.down"
                )
                editField(
                    label: "Score",
                    value: String(data.userScore),
                    systemImage: "star.fill"
                )
            }
            .padding(.top, 8)
        }
    }
    
    private func editField(label: String, value: String, systemImage: String) -> some View {
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
    List([data, dataMinimum]) { media in
        UserMediaCard(data: media)
    }
    .listStyle(.plain)
}
