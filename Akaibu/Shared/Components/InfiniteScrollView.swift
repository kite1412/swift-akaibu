//
//  InfiniteScrollView.swift
//  Akaibu
//
//  Created by kite1412 on 08/02/26.
//

import SwiftUI
import OSLog

struct InfiniteScrollView<Item: Identifiable, Content: View>: View {
    var items: [Item]
    var loadMore: (() -> Void)?
    var content: (Item) -> Content
    
    var body: some View {
        LazyVStack {
            ForEach(items) { item in
                content(item)
            }
            
            if let loadMore {
                ProgressView()
                    .progressViewStyle(.circular)
                    .onAppear {
                        debugOnly {
                            AppLogger.data.debug("Load new data")
                        }
                        loadMore()
                    }
                    .padding()
            }
        }
    }
}

#Preview {
    InfiniteScrollView(
        items: [MockAnime.animeBase, MockAnime.animeBaseMinimum],
        loadMore: {},
        content: { item in
            MediaCard(media: item.toMediaCardData())
        }
    )
}
