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
    private var nextResults: [String: NextResultClosure<[UserMediaData]>] = [:]
    private var userMedia: [UserMediaData] = []
    
    let service: UserMediaService
    
    @Published var filteredUserMediaList: [UserMediaData] = []
    @Published var selectedStatus: String = "All"
    @Published var uiState: UIState = .loading

    var isNextResultAvailable: Bool {
        if
            let stored = nextResults[selectedStatus],
            let _ = stored
        {
            return true
        } else {
            return false
        }
    }
    
    init(service: UserMediaService) {
        self.service = service
        loadByStatus("All")
    }
    
    func loadByStatus(_ status: String) {
        Task {
            let fetchResult = await FetchHelpers.tryFetch {
                uiState = .loading
                var params: [String: String]? = nil
                let mediaCount = userMedia.count(where: { $0.userStatus == status })
                
                if mediaCount > 0 {
                    params = ["offset": "\(mediaCount)"]
                }
                
                return try await service.getUserMediaList(
                    status: UserAnimeStatus(rawValue: status)?.rawValue ?? nil,
                    params: params
                )
            }
            if case .success(let data) = fetchResult {
                addToAllList(data.data)
                nextResults[status] = data.next
            }
            uiState = fetchResult.toUIState()
            
            filteredUserMediaList = currentListByStatus()
        }
    }
    
    func changeSelectedStatus(_ status: String) {
        selectedStatus = status
        
        if let _ = nextResults[status] {
            filteredUserMediaList = currentListByStatus()
        } else {
            loadByStatus(status)
        }
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
    
    func filterByTitle(_ title: String) {
        if title.isEmpty {
            filteredUserMediaList = currentListByStatus()
            return
        }
        
        filteredUserMediaList = currentListByStatus().filter { media in
            media.title.localizedCaseInsensitiveContains(title)
        }
    }
    
    func loadMoreMedia() {
        if
            let stored = nextResults[selectedStatus],
            let nextResult = stored
        {
            Task {
                let res = await FetchHelpers.tryFetch {
                    try await nextResult()
                }
                
                if case .success(let data) = res {
                    addToAllList(data?.data ?? [])
                    nextResults[selectedStatus] = data?.next
                    filteredUserMediaList = currentListByStatus()
                } else {
                    nextResults[selectedStatus] = nil
                }
            }
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
                if let index = userMedia.firstIndex(where: { $0.id == data.id }) {
                    if media.userStatus == data.userStatus {
                        userMedia[index] = data
                    } else {
                        userMedia.remove(at: index)
                        
                        userMedia.append(data)
                    }
                    filteredUserMediaList = currentListByStatus()
                }
            }
        }
    }
    
    private func currentListByStatus() -> [UserMediaData] {
        selectedStatus == "All" ? userMedia : userMedia.filter { media in
            media.userStatus == selectedStatus
        }
    }
    
    private func addToAllList(_ list: [UserMediaData]) {
        userMedia.append(contentsOf: list.filterUnique(with: userMedia))
    }
}
