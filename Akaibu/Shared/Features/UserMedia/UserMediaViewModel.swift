//
//  UserMediaViewModel.swift
//  Akaibu
//
//  Created by kite1412 on 03/01/26.
//

import Foundation
import Combine

@MainActor
class UserMediaViewModel: ObservableObject {
    let service: UserMediaService
    
    @Published var filteredUserMediaList: [UserMediaData] = []
    @Published var selectedStatus: String = "All"
    @Published var uiState: UIState = .loading
    
    private var userMediaList: [String: [UserMediaData]] = [:]
    private var nextResults: [String: NextResultClosure<[UserMediaData]>] = [:]
    
    init(service: UserMediaService) {
        self.service = service
        Task {
            let fetchResult = await FetchHelpers.tryFetch {
                try await service.getUserMediaList(status: nil)
            }
            if case .success(let data) = fetchResult {
                addToAllList(data.data)
                saveNextResult(status: "All", nextResult: data.next)
            }
            uiState = fetchResult.toUIState()
            
            filteredUserMediaList = currentListByStatus()
        }
    }
    
    func changeSelectedStatus(_ status: String) {
        selectedStatus = status
        filteredUserMediaList = currentListByStatus()
    }
    
    func updateMediaScore(for media: UserMediaData, score: Int) {
        if media.userScore == score {
            return
        }
        
        updateMediaProgress(for: media) { [weak self] in
            try await self?.service.updateScore(for: media, with: score) ?? media
        }
    }
    
    func updateMediaStatus(for media: UserMediaData, status: String) {
        if media.userStatus == status {
            return
        }
        
        updateMediaProgress(for: media) { [weak self] in
            try await self?.service.updateStatus(for: media, with: status) ?? media
        }
    }
    
    func updateMediaConsumedUnits(for media: UserMediaData, consumedUnits: Int) {
        if media.consumedUnits == consumedUnits {
            return
        }
        
        updateMediaProgress(for: media) { [weak self] in
            try await self?.service.updateConsumedUnits(for: media, with: consumedUnits) ?? media
        }
    }
    
    private func updateMediaProgress(
        for media: UserMediaData,
        with operation: @escaping () async throws -> UserMediaData
    ) {
        Task {
            let updated = await FetchHelpers.tryFetch {
                try await operation()
            }
            
            if case .success(let data) = updated {
                if let index = userMediaList[media.userStatus]?.firstIndex(where: { $0.id == data.id }) {
                    if media.userStatus == data.userStatus {
                        userMediaList[media.userStatus]?[index] = data
                    } else {
                        userMediaList[media.userStatus]?.remove(at: index)
                        
                        if userMediaList[data.userStatus] == nil {
                            userMediaList[data.userStatus] = []
                        }
                        
                        userMediaList[data.userStatus]?.append(data)
                    }
                    filteredUserMediaList = currentListByStatus()
                }
            }
        }
    }
    
    private func currentListByStatus() -> [UserMediaData] {
        (selectedStatus == "All" ? userMediaList.flatMap(\.value) : userMediaList[selectedStatus] ?? [])
            .sorted {
                $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending
            }
    }
    
    private func addToAllList(_ list: [UserMediaData]) {
        let grouped = Dictionary(grouping: list) { media in media.userStatus }
        
        grouped.forEach { key, mediaList in
            if userMediaList[key] == nil {
                userMediaList[key] = []
            }
            
            userMediaList[key]?.append(contentsOf: mediaList)
        }
    }
    
    private func saveNextResult(status: String, nextResult: NextResultClosure<[UserMediaData]>) {
        nextResults[status] = nextResult
    }
}
