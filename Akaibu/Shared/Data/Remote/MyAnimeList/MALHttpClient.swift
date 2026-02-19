//
//  MALHTTPClient.swift
//  Akaibu
//
//  Created by kite1412 on 28/12/25.
//

import Foundation

class MALHTTPClient: HTTPClient {
    static let shared = MALHTTPClient()
    
    private init() {
        super.init(baseURL: URL(string: MALPaths.baseURLString)!)
    }
    
    func withDefaultGetMediaParams(_ other: [String: String]) -> [String: String] {
        var result = other
        result["nsfw"] = "true"
        return result
    }
}
