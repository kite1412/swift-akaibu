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
        super.init(baseURL: URL.init(string: "https://api.myanimelist.net/v2/")!)
    }
}
