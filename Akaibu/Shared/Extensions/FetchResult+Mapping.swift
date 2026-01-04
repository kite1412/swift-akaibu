//
//  FetchResult+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 04/01/26.
//

extension FetchResult {
    func toUIState() -> UIState {
        switch self {
        case .success: return .success
        case .failure: return .failure
        case .loading: return .loading
        }
    }
}
