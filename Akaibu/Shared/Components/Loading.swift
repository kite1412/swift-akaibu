//
//  Loading.swift
//  Akaibu
//
//  Created by kite1412 on 05/01/26.
//

import SwiftUI

struct Loading: View {
    let loadingText: String?
    
    var body: some View {
        VStack {
            ProgressView()
                .progressViewStyle(.circular)
            if let loadingText {
                Text(loadingText)
                    .font(.caption)
                    .italic()
            }
        }
        .foregroundStyle(.secondary)
    }
}

#Preview {
    Loading(loadingText: nil)
}
