//
//  DateString.swift
//  Akaibu
//
//  Created by kite1412 on 20/02/26.
//

import Foundation

func dayTimeLocalized(day: Day, time: String, from timeZone: TimeZone) -> (Day, String) {
    let formatter = Foundation.DateFormatter()
    formatter.dateFormat = "EEEE HH:mm"
    formatter.timeZone = timeZone
    
    guard let date = formatter.date(from: "\(day.rawValue) \(time)") else {
        return (day, time)
    }
    
    formatter.timeZone = .current
    
    let strings = formatter.string(from: date).split(separator: " ").map(String.init)
    
    if let day = Day(rawValue: strings[0].lowercased()), strings.count == 2 {
        return (day, strings[1])
    } else {
        return (day, time)
    }
}
