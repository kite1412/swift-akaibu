//
//  iOSMainView.swift
//  Akaibu
//
//  Created by kite1412 on 25/12/25.
//

import SwiftUI

struct iOSMainView: View {
    // Tweak one or more tabs to access unlisted tabs here.
    var body: some View {
        TabView {
            ForEach(Destination.allCases.prefix(4), id: \.self) { des in
                NavigationStack {
                    des.content
                        .navigationTitle(des.title)
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                TopBar()
                            }
                        }
                }
                .tabItem {
                    Label(des.title, systemImage: des.systemImage)
                }
            }
        }
    }
}

#Preview {
    iOSMainView()
}
