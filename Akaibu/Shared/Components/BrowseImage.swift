//
//  BrowseImage.swift
//  Akaibu
//
//  Created by kite1412 on 30/12/25.
//

import SwiftUI
import Kingfisher

struct BrowseImage: View {
    let url: URL?
    
    init(_ url: URL?) {
        self.url = url
    }
    
    var body: some View {
        KFImage.url(url)
            .placeholder {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .progressViewStyle(.circular)
                    .background(.gray.opacity(0.2))
            }
            .onFailureView {
                VStack {
                    Image(systemName: "rectangle.slash")
                        .font(.title)
                    Text("No Image")
                        .italic()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.thinMaterial)
            }
            .resizable()
    }
}

#Preview {
    BrowseImage(nil)
}
