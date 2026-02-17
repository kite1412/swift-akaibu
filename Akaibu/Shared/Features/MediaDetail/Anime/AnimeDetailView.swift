//
//  AnimeDetailView.swift
//  Akaibu
//
//  Created by kite1412 on 17/02/26.
//

import SwiftUI

struct AnimeDetailView: View {
    @StateObject private var viewModel: AnimeDetailViewModel
    
    init(animeId: Int) {
        _viewModel = StateObject(wrappedValue:  AnimeDetailViewModel(animeId: animeId))
    }
    
    var body: some View {
        MediaDetailView(
            data: viewModel.mediaDetail,
            availableStatuses: UserAnimeStatus.allCases.map(\.rawValue),
            onGoingStatus: UserAnimeStatus.watching.rawValue,
            completedStatus: UserAnimeStatus.completed.rawValue,
            onUserMediaProgressUpdate: { progress in }
        )
    }
}

#Preview {
    AnimeDetailView(animeId: 1)
}
