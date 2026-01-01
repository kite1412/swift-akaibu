//
//  Rating.swift
//  Akaibu
//
//  Created by kite1412 on 29/12/25.
//

enum Rating: String {
    case safe = "All Ages"
    case parentalGuidance = "Parental Guidance"
    case teen = "17+"
    case mature = "Mild Adult Content"
    case adult = "Adult Content"
    
    var isAdult: Bool {
        self == .adult
    }
}
