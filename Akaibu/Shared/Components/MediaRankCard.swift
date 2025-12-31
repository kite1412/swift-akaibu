//
//  MediaRankCard.swift
//  Akaibu
//
//  Created by kite1412 on 30/12/25.
//

import SwiftUI
import Kingfisher

struct MediaRankCard: View {
    let mediaRank: MediaRank
    
    var body: some View {
        HStack(spacing: 4) {
            HStack(alignment: .top) {
                BrowseImage(mediaRank.coverImageURL)
                    .aspectRatio(2/3, contentMode: .fit)
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .font(.caption)
                
                VStack(alignment: .leading) {
                    Text(mediaRank.title)
                        .font(.headline)
                    
                    if let description = mediaRank.synopsis {
                        Text(description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .lineLimit(2)
                            .truncationMode(.tail)
                    }
                    
                    HStack {
                        MediaLabel(mediaRank.type, kind: .type)
                        MediaLabel(mediaRank.status, kind: .status)
                        if mediaRank.isAdult {
                            MediaLabel("Adult", kind: .adult)
                        }
                        
                    }
                    .font(.caption)
                }
                .padding(4)
            }
            
            Spacer()
            VStack {
                Text("#\(mediaRank.rank)")
                    .font(.title)
                    .foregroundStyle(.gray)
                    .italic()
                    .fontWeight(.medium)
                
                HStack(spacing: 2) {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                    Text(String(format: "%.2f", mediaRank.score))
                }
                .font(.caption)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

private let mediaRank = MediaRank(
    id: 1,
    title: "Media Title",
    synopsis: "Media with a very long long long long long long long long long long Synopsis",
    rank: 1,
    type: "Type",
    status: "Completed",
    coverImageURL: URL.init(string: "https://picsum.photos/300/200"),
    isAdult: true,
    score: 9.62
)

private var minimum = MediaRank(
    id: 2,
    title: "Media Title",
    synopsis: nil,
    rank: 2,
    type: "Type",
    status: "Airing",
    coverImageURL: nil,
    isAdult: false,
    score: 9.210
)

#Preview {
    VStack {
        ForEach([mediaRank, minimum]) { mediaRank in
            MediaRankCard(mediaRank: mediaRank)
        }
    }
    .padding()
}
