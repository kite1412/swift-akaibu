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
    
    private var userMediaList: [String: [UserMediaData]] = [
        "All": [userMediaData, userMediaDataMinimum]
    ]
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
    
    private func allList() -> [UserMediaData] {
        userMediaList.flatMap(\.value)
            .sorted { 
                $0.updatedAt > $1.updatedAt
            }
    }
    
    private func addToAllList(_ list: [UserMediaData]) {
        let all = Array(Set((userMediaList["All"] ?? []) + list))
        userMediaList["All"] = all
    }
    
    private func saveNextResult(status: String, nextResult: NextResultClosure<[UserMediaData]>) {
        nextResults[status] = nextResult
    }
}
