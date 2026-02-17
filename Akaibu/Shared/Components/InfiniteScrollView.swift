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
    var loadMoreEnabled: Bool = true
    var content: (Item) -> Content
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(items) { item in
                    content(item)
                }
                .padding(.vertical, 4)
                
                if let loadMore {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .opacity(loadMoreEnabled ? 1 : 0)
                        .onAppear {
                            if loadMoreEnabled {
                                debugOnly {
                                    AppLogger.data.debug("Load new data")
                                }
                                loadMore()
                            }
                        }
                        .padding()
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
            MediaCard(media: item.toMediaCardData(), onClick: { id in })
        }
    )
}
