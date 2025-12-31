//
//  MediaSlider.swift
//  Akaibu
//
//  Created by kite1412 on 01/01/26.
//

import SwiftUI

struct MediaSlider: View {
    let data: [MediaSliderData]
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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
