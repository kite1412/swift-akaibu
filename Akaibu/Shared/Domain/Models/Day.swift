//
//  Day.swift
//  Akaibu
//
//  Created by kite1412 on 20/02/26.
//

import Foundation

enum Day: String, CaseIterable {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    
    static func today() -> Day {
        let formatter = Foundation.DateFormatter()
        formatter.dateFormat = "EEEE"
        let todayName = formatter.string(from: Date())
        
        return Day(rawValue: todayName.lowercased())!
    }
    
    /// 0 equal, 1 later (`day`), -1 earlier (`day`), -2 invalid input
    func compare(to day: Day) -> Int {
        guard let toIndex = Day.allCases.firstIndex(of: day) else { return -2 }
        guard let dayIndex = Day.allCases.firstIndex(of: self) else { return -2 }
        
        if dayIndex > toIndex { return 1 }
        if dayIndex < toIndex { return -1 }
        return 0
    }
}
