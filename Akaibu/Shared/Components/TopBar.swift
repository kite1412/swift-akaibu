//
//  TopBar.swift
//  Akaibu
//
//  Created by kite1412 on 25/12/25.
//

import SwiftUI

struct TopBar: View {
    private var iconSize: CGFloat {
        #if os(iOS)
        return UIFont.preferredFont(forTextStyle: .title1).pointSize * 2
        #elseif os(macOS)
        return NSFont.preferredFont(forTextStyle: .title1).pointSize * 2
        #endif
    }
    
    @State private var searchTitle: String = ""
    @State private var isSearchPresented: Bool = true
    
    var body: some View {
        HStack {
            Image(Images.appIcon)
                .resizable()
                .scaledToFit()
                .frame(height: iconSize)
            VStack(alignment: .leading) {
                Text("Akaibu")
                    .font(.title)
                    .fontWeight(.bold)
                Text("アーカイブ")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    TopBar()
}
