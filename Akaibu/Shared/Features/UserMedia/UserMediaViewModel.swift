//
//  UserMediaViewModel.swift
//  Akaibu
//
//  Created by kite1412 on 03/01/26.
//

import Combine

@MainActor
class UserMediaViewModel: ObservableObject {
    private var userMediaList: [UserMediaData] = [userMediaData, userMediaDataMinimum]
    
    @Published var filteredUserMediaList: [UserMediaData] = [userMediaData, userMediaDataMinimum]
    @Published var selectedStatus: String = "All"
    
    func changeSelectedStatus(_ status: String) {
        selectedStatus = status
        filteredUserMediaList = status == "All" ? userMediaList : userMediaList.filter { media in
            media.userStatus == status
        }
    }
}
