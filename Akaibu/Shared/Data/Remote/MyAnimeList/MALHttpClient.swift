//
//  MALHttpClient.swift
//  Akaibu
//
//  Created by kite1412 on 28/12/25.
//

import Foundation

class MALHttpClient: HTTPClient {
    static let shared = MALHttpClient()
    
    private init() {
        super.init(baseURL: URL.init(string: MALPaths.baseURLString)!)
    }
    
    func mergeParams(_ a: [String: String], _ b: [String: String]?) -> [String: String] {
        a.merging(b ?? [:]) { (_, new) in new }
    }
    
    func withDefaultGetMediaParams(_ other: [String: String]) -> [String: String] {
        var result = other
        result["nsfw"] = "true"
        return result
    }
}
