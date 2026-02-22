//
//  MediaRankingViewModel.swift
//  Akaibu
//
//  Created by kite1412 on 22/02/26.
//

import Combine

@MainActor
class MediaRankingViewModel: ObservableObject {
    private let service: MediaRankingService
    var nextResult: NextResultClosure<[MediaRank]> = nil
    
    @Published var mediaRankingResult: FetchResult<[MediaRank]> = .loading
    
    init(service: MediaRankingService) {
        self.service = service
        
        Task {
            let res = await FetchHelpers.tryFetch(service.getMediaRanking)
            
            updateMediaRankingResult(with: res)
        }
    }
    
    func loadMoreResult() {
        if case .success = mediaRankingResult {
            if let nextResult {
                Task {
                    let res = await FetchHelpers.tryFetch(nextResult)
                    
                    updateMediaRankingResult(with: res)
                }
            }
        } else {
            nextResult = nil
        }
    }
    
    private func updateMediaRankingResult(with result: FetchResult<PaginatedResult<[MediaRank]>>) {
        switch result {
        case .success(let data):
            if case .success(let prevData) = mediaRankingResult {
                mediaRankingResult = .success(data: prevData + data.data)
            } else {
                mediaRankingResult = .success(data: data.data)
            }
            nextResult = data.next
        case .failure(let error):
            mediaRankingResult = .failure(error)
        case .loading:
            mediaRankingResult = .loading
        }
    }
    
    private func updateMediaRankingResult(with result: FetchResult<PaginatedResult<[MediaRank]>?>) {
        switch result {
        case .success(let data):
            if let data {
                if case .success(let prevData) = mediaRankingResult {
                    mediaRankingResult = .success(data: prevData + data.data)
                } else {
                    mediaRankingResult = .success(data: data.data)
                }
                nextResult = data.next
            }
        case .failure(let error):
            mediaRankingResult = .failure(error)
        case .loading:
            mediaRankingResult = .loading
        }
    }
}
