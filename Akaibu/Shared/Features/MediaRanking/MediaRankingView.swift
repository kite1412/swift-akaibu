//
//  MediaRankingView.swift
//  Akaibu
//
//  Created by kite1412 on 22/02/26.
//

import SwiftUI

struct MediaRankingView: View {
    private let mediaType: String
    private let onMediaClick: (Int) -> Void
    
    @StateObject private var viewModel: MediaRankingViewModel
    
    init(mediaType: String, service: MediaRankingService, onMediaClick: @escaping (Int) -> Void) {
        self.mediaType = mediaType
        self.onMediaClick = onMediaClick
        _viewModel = StateObject(wrappedValue: MediaRankingViewModel(service: service))
    }
    
    var body: some View {
        FetchStateView(
            fetchResult: viewModel.mediaRankingResult,
            loadingText: "Loading \(mediaType) ranking...",
            errorText: "Failed to get \(mediaType) ranking."
        ) { ranking in
            InfiniteScrollView(
                items: ranking,
                loadMore: loadMore
            ) { media in
                ZStack(alignment: .topLeading) {
                    MediaCard(
                        media: media.toMediaCardData(),
                        onClick: onMediaClick
                    )
                    
                    Text("#\(media.rank)")
                        .padding(4)
                        .font(.title)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .padding(.horizontal)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("\(mediaType) Ranking")
    }
    
    var loadMore: (() -> Void)? {
        viewModel.nextResult.map { _ in
            {
                viewModel.loadMoreResult()
            }
        }
    }
}

#Preview {
    MediaRankingView(
        mediaType: "Any",
        service: AnimeRankingService()
    ) { _ in }
}
