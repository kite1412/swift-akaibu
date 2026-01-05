//
//  FetchStateView.swift
//  Akaibu
//
//  Created by kite1412 on 31/12/25.
//

import SwiftUI

/// A very minimal view to display different UI based on ``FetchResult`` state.
struct FetchStateView<Data, Content: View>: View {
    let fetchResult: FetchResult<Data>
    let successView: (Data) -> Content
    private var errorText: String = "Failed to fetch data."
    private var loadingText: String? = nil
    
    init(fetchResult: FetchResult<Data>, @ViewBuilder successView: @escaping (Data) -> Content) {
        self.fetchResult = fetchResult
        self.successView = successView
    }
    
    init(
        fetchResult: FetchResult<Data>,
        loadingText: String,
        @ViewBuilder successView: @escaping (Data) -> Content
    ) {
        self.fetchResult = fetchResult
        self.successView = successView
        self.loadingText = loadingText
    }
    
    init(
        fetchResult: FetchResult<Data>,
        loadingText: String,
        errorText: String,
        @ViewBuilder successView: @escaping (Data) -> Content
    ) {
        self.fetchResult = fetchResult
        self.successView = successView
        self.loadingText = loadingText
        self.errorText = errorText
    }
    
    init(
        fetchResult: FetchResult<Data>,
        errorText: String,
        @ViewBuilder successView: @escaping (Data) -> Content
    ) {
        self.fetchResult = fetchResult
        self.successView = successView
        self.errorText = errorText
    }
    
    var body: some View {
        switch fetchResult {
        case .failure:
            Text(errorText)
        case .success(let data):
            successView(data)
        case .loading:
            Loading(loadingText: loadingText)
        }
    }
}

#Preview {
    FetchStateView(
        fetchResult: .loading
    ) {
        Text("Success")
    }
}
