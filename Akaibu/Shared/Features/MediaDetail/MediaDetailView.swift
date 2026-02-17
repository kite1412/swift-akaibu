//
//  MediaDetailView.swift
//  Akaibu
//
//  Created by kite1412 on 14/02/26.
//

import SwiftUI
import Foundation

struct MediaDetailView: View {
    let data: MediaDetailData
    var additionalDetail: (() -> AnyView)? = nil
    
    @State var isSynopsisExpanded: Bool = false
    
    private let synopsisLimit: Int = 200
    private var isSynopsisExceedingLimit: Bool {
        data.synopsis.map { $0.count > synopsisLimit } ?? false
    }
    
    init(data: MediaDetailData) {
        self.data = data
    }
    
    init(data: MediaDetailData, @ViewBuilder additionalDetail: @escaping () -> some View) {
        self.data = data
        self.additionalDetail = { AnyView(additionalDetail()) }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .top) {
                    BrowseImage(data.coverImageURL)
                        .aspectRatio(2/3, contentMode: .fit)
                        .frame(maxHeight: 240)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    
                    VStack(alignment: .leading, spacing: 16) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(data.title)
                                .font(.title)
                            
                            score
                            genres
                        }
                        
                        VStack(alignment: .leading) {
                            alternativeTitles
                            rank
                            additionalDetail?()
                        }
                        .font(.subheadline)
                        
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
                if let synopsis = data.synopsis {
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text("Synopsis")
                                .foregroundStyle(.primary)
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            
                        }
                        
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
                            isSynopsisExpanded.toggle()
                        }
                    }
                }
            }
        }
    }
    
    private var score: some View {
        HStack(spacing: 16) {
            detailRow(
                systemImageName: "star.fill",
                label: data.score.map { String(format: "%.2f", $0) } ?? "N/A",
                imageStyle: .yellow,
                textStyle: .primary
            )
            
            if let scoringUsers = data.scoringUsers {
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
    
    private var genres: some View {
        HStack(spacing: 4) {
            ForEach(data.genres, id: \.self) { genre in
                Text(genre)
                    .font(.caption2)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 8)
                    .background(.thickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
    }
    
    @ViewBuilder
    private var alternativeTitles: some View {
        if !data.alternativeTitles.isEmpty {
            Text("Title: \(data.alternativeTitles.joined(separator: ", "))")
                .italic()
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
    
    @ViewBuilder
    private var rank: some View {
        let systemName = "number"
        
        if let rank = data.rank {
            detailRow(systemImageName: systemName, label: rank)
        } else {
            detailRow(systemImageName: systemName, label: "Not Ranked")
        }
    }
    
    private func detailRow(
        systemImageName: String,
        label: String,
        imageStyle: some ShapeStyle = .secondary,
        textStyle: some ShapeStyle = .secondary
    ) -> some View {
        HStack(spacing: 4) {
            Image(systemName: systemImageName)
                .foregroundStyle(imageStyle)
            
            Text(label)
                .foregroundStyle(textStyle)
        }
    }
    
    private func detailRow(
        systemImageName: String,
        label: Int,
        imageStyle: some ShapeStyle = .secondary,
        textStyle: some ShapeStyle = .secondary
    ) -> some View {
        HStack(spacing: 4) {
            Image(systemName: systemImageName)
                .foregroundStyle(imageStyle)
            
            Text(label, format: .number.locale(Locale(identifier: "en_US")))
                .foregroundStyle(textStyle)
        }
    }
}

#Preview {
    MediaDetailView(
        data: MediaDetailData(
            title: "A title",
            synopsis: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
            coverImageURL: URL(string: "https://picsum.photos/300/200"),
            type: "A type",
            status: "Completed",
            isAdult: true,
            genres: ["genre 1", "genre 2", "genre 3", "genre 4"],
            score: 8,
            scoringUsers: 10000,
            alternativeTitles: ["A title", "Another title"],
            rank: 1000,
            userProgress: UserMediaProgress(
                status: "Completed",
                score: 8,
                consumedUnits: 10,
                updatedAt: Date()
            )
        ),
        additionalDetail: {
            Text("Additional detail")
        }
    )
}
