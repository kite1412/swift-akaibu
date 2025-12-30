//
//  MALRating+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 31/12/25.
//

extension MALRating {
    func toDomain() -> Rating {
        switch self {
        case .g, .pg, .pg13: return.safe
        case .r: return .teen
        case .rPlus: return .mature
        case .rx: return .adult
        }
    }
}
