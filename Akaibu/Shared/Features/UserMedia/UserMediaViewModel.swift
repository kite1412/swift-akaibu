//
//  UserMediaViewModel.swift
//  Akaibu
//
//  Created by kite1412 on 03/01/26.
//

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
            
            filteredUserMediaList = allList()
        }
    }
    
    func changeSelectedStatus(_ status: String) {
        selectedStatus = status
        filteredUserMediaList = status == "All" ? allList() : allList().filter { media in
            media.userStatus == status
        }
    }
    
    func updateMediaScore(for media: UserMediaData, score: Int) {
        Task {
            let updated = await FetchHelpers.tryFetch {
                try await service.updateScore(for: media, with: score)
            }
            
            if case .success(let data) = updated {
                if let index = userMediaList[data.userStatus]?.firstIndex(where: { $0.id == data.id }) {
                    userMediaList[data.userStatus]?[index] = data
                    filteredUserMediaList = selectedStatus == "All" ? allList() : userMediaList[selectedStatus] ?? []
                }
            }
        }
    }
    
    private func allList(sorted: Bool = true) -> [UserMediaData] {
        let all = userMediaList.flatMap(\.value)
        
        if sorted {
            return all.sorted {
                $0.updatedAt > $1.updatedAt
            }
        } else {
            return all
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
