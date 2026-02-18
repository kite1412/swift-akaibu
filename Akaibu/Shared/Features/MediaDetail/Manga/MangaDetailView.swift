//
//  MangaDetailView.swift
//  Akaibu
//
//  Created by kite1412 on 18/02/26.
//

import SwiftUI

struct MangaDetailView: View {
    @StateObject private var viewModel: MangaDetailViewModel
    
    init(mangaId: Int) {
        _viewModel = StateObject(wrappedValue: MangaDetailViewModel(mangaId: mangaId))
    }
    
    var body: some View {
        MediaDetailView(
            data: viewModel.mediaDetail,
            availableStatuses: UserMangaStatus.allCases.map(\.rawValue),
            onGoingStatus: UserMangaStatus.reading.rawValue,
            completedStatus: UserMangaStatus.completed.rawValue,
            additionalDetails: [],
            onUserMediaProgressUpdate: { progress in }
        )
    }
}

#Preview {
    MangaDetailView(mangaId: 1)
}
