//
//  MediaCard.swift
//  Akaibu
//
//  Created by kite1412 on 29/12/25.
//

import SwiftUI
import Kingfisher

struct MediaCard: View {
    let media: MediaCardData
    let onClick: (_ id: Int) -> Void
    var content: (() -> AnyView)? = nil
    
    init(media: MediaCardData, onClick: @escaping (Int) -> Void) {
        self.media = media
        self.onClick = onClick
    }
    
    init(media: MediaCardData, onClick: @escaping (Int) -> Void, @ViewBuilder content: @escaping () -> some View) {
        self.init(media: media, onClick: onClick)
        self.content = { AnyView(content()) }
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            ZStack {
                BrowseImage(media.coverImageURL)
                
                if media.isAdult {
                    MediaLabel("Adult", kind: .adult)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .padding(4)
                        .font(.caption2)
                }
            }
            .aspectRatio(2/3, contentMode: .fit)
            .frame(maxHeight: 160)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading, spacing: 8) {
                Text(media.title)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .font(.title3)
                    .fontWeight(.bold)
                
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 8) {
                            score
                            scoringUsers
                        }
                        
                        genres
                    }
                    
                    if let desc = media.synopsis {
                        Text(desc)
                            .font(.caption)
                            .lineLimit(2)
                            .truncationMode(.tail)
                    }
                }
                
                others
                content?()
            }
            .padding(.top, 8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(8)
        .padding(.trailing, 16)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.primary.opacity(0.5), lineWidth: 2)
                .fill(.ultraThinMaterial)
        )
        .onTapGesture {
            onClick(media.id)
        }
    }
    
    private var score: some View {
        HStack(spacing: 4) {
            Image(systemName: "star.fill")
                .foregroundStyle(.yellow)
            Text(media.score.map { String(format: "%.2f", $0) } ?? "N/A")
        }
        .font(.caption)
    }
    
    private var genres: some View {
        HStack(spacing: 8) {
            ForEach(Array(media.genres.prefix(3)), id: \.self) { genre in
                Text(genre)
            }
        }
        .font(.caption2)
        .foregroundStyle(.gray)
    }
    
    private var others: some View {
        HStack {
            MediaLabel(media.type, kind: .type)
            MediaLabel(media.status, kind: .status)
        }
        .font(.caption2)
    }
    
    @ViewBuilder
    private var scoringUsers: some View {
        if let total = media.scoringUsers {
            HStack(spacing: 2) {
                Image(systemName: "person.2.fill")
                    .foregroundStyle(.gray)
                
                Text("\(total)")
            }
            .foregroundStyle(.gray)
            .italic()
            .font(.caption2)
        }
    }

    private func otherInformationLabel(
        for text: String,
        color: Color,
        backgroundColor: Color
    ) -> some View {
        Text(text)
            .foregroundStyle(color)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(backgroundColor)
            )
    }
}

private let animeBase = MockAnime.animeBase
private let animeBaseMinimum = MockAnime.animeBaseMinimum

private let mock = MediaCardData(
    id: animeBase.id,
    title: animeBase.title,
    synopsis: animeBase.synopsis,
    coverImageURL: animeBase.coverImageURL,
    isAdult: animeBase.rating.isAdult,
    genres: animeBase.genres,
    score: animeBase.score,
    type: animeBase.type,
    status: animeBase.airingStatus.rawValue,
    scoringUsers: animeBase.scoringUsers
)

private let minimum = MediaCardData(
    id: animeBaseMinimum.id,
    title: animeBaseMinimum.title,
    synopsis: animeBaseMinimum.synopsis,
    coverImageURL: animeBaseMinimum.coverImageURL,
    isAdult: animeBase.rating.isAdult,
    genres: animeBaseMinimum.genres,
    score: animeBaseMinimum.score,
    type: animeBaseMinimum.type,
    status: animeBaseMinimum.airingStatus.rawValue,
    scoringUsers: animeBaseMinimum.scoringUsers
)

#Preview {
    ScrollView {
        ForEach([mock, minimum]) { data in
            MediaCard(media: data, onClick: { id in })
        }
        .padding()
    }
}
