//
//  AnimeSchedulesViewModel.swift
//  Akaibu
//
//  Created by kite1412 on 21/02/26.
//

import Combine
import Foundation

@MainActor
class AnimeSchedulesViewModel: ObservableObject {
    private let animeRepository = DIContainer.shared.animeRepository
    private var storedResults: [String: FetchResult<[AnimeSchedule]>] = [:]
    
    @Published var nextResults: [String: NextResultClosure<[AnimeSchedule]>] = [:]
    @Published var selectedDayString: String // always capitalized
    @Published var fetchResult: FetchResult<[AnimeSchedule]> = .loading
    
    var selectedDay: Day {
        Day(rawValue: selectedDayString.lowercased())!
    }
    var isNextResultAvailable: Bool {
        if let nextResult = nextResults[selectedDayString] {
            if nextResult != nil {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    init() {
        self.selectedDayString = Day.today().rawValue.capitalized
        fetchAnimeSchedules()
    }
    
    func changeSelectedDay(with day: String) {
        selectedDayString = day
        
        if let storedResult = storedResults[day] {
            fetchResult = storedResult
        } else {
            fetchAnimeSchedules()
        }
    }
    
    func loadMore() {
        if let nextResult = nextResults[selectedDayString] {
            if let nextResult {
                Task {
                    let res = await FetchHelpers.tryFetch(nextResult)
                    
                    if case .success(let data) = res {
                        if case .success(let prevData) = self.fetchResult, let data = data {
                            let updatedResult = FetchResult.success(data: prevData + data.data)
                            self.fetchResult = updatedResult
                            self.storedResults[selectedDayString] = updatedResult
                            self.nextResults[selectedDayString] = data.next
                        }
                    }
                }
            }
        }
    }
    
    private func fetchAnimeSchedules() {
        Task {
            fetchResult = .loading
            
            let res = await FetchHelpers.tryFetch {
                try await animeRepository.getAnimeSchedules(for: selectedDay)
            }
            
            if case .success(let data) = res {
                let fetchResult: FetchResult = .success(data: data.data)
                storedResults[self.selectedDayString] = fetchResult
                self.fetchResult = fetchResult
                self.nextResults[selectedDayString] = data.next
            }
        }
    }
}
