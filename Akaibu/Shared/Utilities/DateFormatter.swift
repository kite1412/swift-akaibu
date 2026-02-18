//
//  DateFormatter.swift
//  Akaibu
//
//  Created by kite1412 on 05/01/26.
//

import Foundation

struct DateFormatter {
    private init() {}
    
    static func format(dateString: String, with formatType: DateFormatterType) -> Date {
        switch formatType {
        case .iso8601:
            let formatter = ISO8601DateFormatter()
            return formatter.date(from: dateString) ?? Date.distantPast
        case .yearMonthDay:
            let formatter = Foundation.DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            return formatter.date(from: dateString) ?? Date.distantPast
        }
    }
    
    static func asString(from date: Date, format: String = "dd MMM yyyy") -> String {
        let formatter = Foundation.DateFormatter()
        
        formatter.dateFormat = format
        formatter.locale = Locale.current
        
        return formatter.string(from: date)
    }
}
