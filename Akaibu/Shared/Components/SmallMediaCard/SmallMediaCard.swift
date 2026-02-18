//
//  SmallMediaCard.swift
//  Akaibu
//
//  Created by kite1412 on 18/02/26.
//

import SwiftUI

struct SmallMediaCard: View {
    let data: SmallMediaCardData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            BrowseImage(data.coverImageURL)
                .aspectRatio(2/3, contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            Text(data.title)
                .font(.caption)
                .lineLimit(2)
                .truncationMode(.middle)
                .padding(.leading, 2)
            
            if let description = data.description {
                Text(description)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .padding(.leading, 2)
                    .lineLimit(4)
                    .truncationMode(.tail)
            }
        }
        .frame(width: 80)
    }
}

#Preview {
    SmallMediaCard(
        data: SmallMediaCardData(
            id: 1,
            title: "A Very Long Long Long Title",
            coverImageURL: URL.init(string: "https://picsum.photos/300/200"),
            description: "A very long long long long long long long long description"
        )
    )
}
