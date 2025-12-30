//
//  MediaLabelKind.swift
//  Akaibu
//
//  Created by kite1412 on 30/12/25.
//

import SwiftUI

enum MediaLabelKind {
    case status
    case type
    case adult
    
    var foregroundColor: Color {
        switch self {
        case .type: return .blue
        case .status: return .green
        case .adult: return .red
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .type: return .blue.opacity(0.3)
        case .status: return .green.opacity(0.3)
        case .adult: return .red.opacity(0.4)
        }
    }
}
