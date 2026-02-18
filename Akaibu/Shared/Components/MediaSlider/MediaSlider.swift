//
//  MediaSlider.swift
//  Akaibu
//
//  Created by kite1412 on 01/01/26.
//

import SwiftUI

struct MediaSlider: View {
    let data: [MediaSliderData]
    let onClick: (_ id: Int) -> Void
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    private var isCompact: Bool {
        horizontalSizeClass == UserInterfaceSizeClass.compact
    }
    
    private var height: CGFloat {
        isCompact ? 150 : 250
    }
    
    // TODO use TabView
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(data) { media in
                            HStack {
                                BrowseImage(media.coverImageUrl)
                                    .aspectRatio(2/3, contentMode: .fit)
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
                                        MediaLabel(media.type, kind: .type)
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
                                .padding(.trailing, isCompact ? 0 : 16)
                            }
                            .padding(isCompact ? 16 : 32) // frame to content
                            .frame(width: geo.size.width, height: geo.size.height, alignment: .leading)
                            .background {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.ultraThickMaterial)
                                    .stroke(.white.opacity(0.4))
                                    .padding(8) // frame to outer
                            }
                            .onTapGesture {
                                onClick(media.id)
                            }
                        }
                    }
                }
                .scrollTargetBehavior(.paging)
            }
        }
        .frame(height: height, alignment: .leading)
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
    type: animeBase.type,
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
    type: animeBase.type,
    score: animeBaseMinimum.score,
    scoringUsers: animeBaseMinimum.scoringUsers,
    isAdult: false,
    genres: animeBaseMinimum.genres,
    status: animeBaseMinimum.airingStatus.rawValue
)

#Preview {
    MediaSlider(data: [media, mediaMinimum], onClick: { id in })
}
