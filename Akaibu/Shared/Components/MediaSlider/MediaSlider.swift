//
//  MediaSlider.swift
//  Akaibu
//
//  Created by kite1412 on 01/01/26.
//

import SwiftUI

struct MediaSlider: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    private var isCompact: Bool {
        horizontalSizeClass == UserInterfaceSizeClass.compact
    }
    
    let data: [MediaSliderData]
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    ForEach(data) { media in
                        HStack(alignment: .top) {
                            BrowseImage(media.coverImageUrl)
                                .aspectRatio(2/3, contentMode: .fit)
                                .frame(maxWidth: min(geo.size.width / 4, 200))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                            VStack(alignment: .leading, spacing: isCompact ? 8 : 16) {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(media.title)
                                        .font(isCompact ? Font.title3 : Font.title)
                                        .fontWeight(.bold)
                                        .lineLimit(1)
                                        .truncationMode(.tail)
                                    
                                    if let synopsis = media.synopsis {
                                        Text(synopsis)
                                            .font(isCompact ? Font.caption : Font.default)
                                            .lineLimit(isCompact ? 2 : 4)
                                    }
                                    
                                    if !media.genres.isEmpty {
                                        HStack(spacing: 8) {
                                            ForEach(media.genres.prefix(isCompact ? 3 : 5), id: \.self) { genre in
                                                Text(genre)
                                            }
                                        }
                                        .foregroundStyle(.secondary)
                                        .font(isCompact ? Font.caption : Font.default)
                                    }
                                }
                                
                                HStack {
                                    MediaLabel(media.status, kind: .status)
                                    
                                    if media.isAdult {
                                        MediaLabel("Adult", kind: .adult)
                                    }
                                    
                                    if isCompact, let score = media.score {
                                        Circle()
                                            .frame(width: 4)
                                            .foregroundStyle(.secondary)
                                        
                                        scoreView(score)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                                .font(isCompact ? Font.caption : Font.default)
                                
                                if !isCompact, let score = media.score {
                                    HStack {
                                        scoreView(score)
                                        if let scoringUsers = media.scoringUsers {
                                            Circle()
                                                .frame(width: 4)
                                            
                                            Text("\(scoringUsers) votes")
                                                .italic()
                                        }
                                    }
                                    .foregroundStyle(.secondary)
                                }
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 16)
                            .padding(.trailing, isCompact ? 0 : 16)
                        }
                        .padding(32)
                        .frame(width: geo.size.width, alignment: .leading)
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.ultraThickMaterial)
                                .stroke(.white.opacity(0.4))
                                .padding()
                        }
                    }
                }
            }
            .scrollTargetBehavior(.paging)
            .scrollIndicators(.hidden)
        }
    }
    
    private func scoreView(_ score: Double) -> some View {
        HStack(spacing: 4) {
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
            Text("\(score, specifier: "%.2f")")
        }
    }
}

private let animeBase = MockAnime.animeBase
private let animeBaseMinimum = MockAnime.animeBaseMinimum

private let media = MediaSliderData(
    id: animeBase.id,
    title: animeBase.title,
    synopsis: animeBase.synopsis,
    coverImageUrl: animeBase.coverImageURL,
    score: animeBase.score,
    scoringUsers: animeBase.scoringUsers,
    isAdult: true,
    genres: animeBase.genres,
    status: animeBase.airingStatus.rawValue
)

private let mediaMinimum = MediaSliderData(
    id: animeBaseMinimum.id,
    title: animeBaseMinimum.title,
    synopsis: animeBaseMinimum.synopsis,
    coverImageUrl: animeBaseMinimum.coverImageURL,
    score: animeBaseMinimum.score,
    scoringUsers: animeBaseMinimum.scoringUsers,
    isAdult: false,
    genres: animeBaseMinimum.genres,
    status: animeBaseMinimum.airingStatus.rawValue
)

#Preview {
    MediaSlider(data: [media, mediaMinimum])
}
