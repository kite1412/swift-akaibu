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
    var loadMore: () -> Void
    var content: (Item) -> Content
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(items) { item in
                    content(item)
                        .onAppear {
                            if item.id == items.last?.id {
                                debugOnly {
                                    AppLogger.data.debug("Load new data")
                                }
                                loadMore()
                            }
                        }
                }
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
