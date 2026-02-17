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
    let onClick: (_ id: Int) -> Void
    
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
        .onTapGesture {
            onClick(mediaRank.id)
        }
    }
}

#Preview {
    VStack {
        ForEach([MockMedia.mediaRank, MockMedia.mediaRankMinimum]) { mediaRank in
            MediaRankCard(mediaRank: mediaRank, onClick: { id in })
        }
    }
    .padding()
}
