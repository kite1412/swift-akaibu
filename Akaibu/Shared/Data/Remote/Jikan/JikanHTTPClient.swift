//
//  JikanHTTPClient.swift
//  Akaibu
//
//  Created by kite1412 on 20/02/26.
//

import Foundation

class JikanHTTPClient: HTTPClient {
    static let shared = JikanHTTPClient()
    
    private init() {
        super.init(baseURL: URL(string: JikanPaths.baseURLString)!)
    }
}
