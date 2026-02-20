//
//  SmallMediaCard.swift
//  Akaibu
//
//  Created by kite1412 on 18/02/26.
//

import SwiftUI

struct SmallMediaCard: View {
    let data: SmallMediaCardData
    let onClick: (_ id: Int) -> Void
    
    private let maxWidth: CGFloat = 80
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            BrowseImage(data.coverImageURL)
                .aspectRatio(2/3, contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .frame(height: (maxWidth * (3 / 2)))
            
            Text(data.title)
                .font(.caption)
                .lineLimit(2)
                .truncationMode(.tail)
                .padding(.leading, 2)
            
            if let description = data.description {
                Text(description)
                    .frame(maxWidth: maxWidth, maxHeight: .infinity, alignment: .topLeading)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .padding(.leading, 2)
                    .lineLimit(4)
                    .truncationMode(.tail)
            }
        }
        .frame(width: maxWidth)
        .onTapGesture {
            onClick(data.id)
        }
    }
}

#Preview {
    SmallMediaCard(
        data: SmallMediaCardData(
            id: 1,
            title: "A Very Long Long Long Title",
            coverImageURL: URL.init(string: "https://picsum.photos/300/200"),
            description: "A very long long long long long long long long description"
        ),
        onClick: { mediaId in }
    )
}
