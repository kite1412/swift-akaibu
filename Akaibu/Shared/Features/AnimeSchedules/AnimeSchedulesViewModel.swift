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
    
    @Published var selectedDayString: String // always capitalized
    @Published var fetchResult: FetchResult<[AnimeSchedule]> = .loading
    
    var selectedDay: Day {
        Day(rawValue: selectedDayString.lowercased())!
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
    
    private func fetchAnimeSchedules() {
        Task {
            fetchResult = .loading
            
            let res = await FetchHelpers.tryFetch {
                try await animeRepository.getAnimeSchedules(for: selectedDay)
            }
            
            if case .success = res {
                storedResults[self.selectedDayString] = res
                fetchResult = res
            }
        }
    }
}
