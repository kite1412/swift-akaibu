//
//  macOSMainView.swift
//  Akaibu
//
//  Created by kite1412 on 25/12/25.
//

import SwiftUI

struct macOSMainView: View {
    private let animation: Animation = .easeInOut(duration: 0.3)
    
    @Binding var currentDestination: Destination
    
    var body: some View {
        NavigationSplitView {
            VStack {
                TopBar()
                List(
                    Destination.allCases,
                    id: \.self
                ) { des in
                    let foregroundStyle = currentDestination == des ? Color.white : Color.primary
                    
                    Button {
                        currentDestination = des
                    } label: {
                        Label {
                            Text(des.title)
                        } icon: {
                            Image(systemName: des.systemImage)
                                .foregroundStyle(foregroundStyle)
                        }
                        .foregroundStyle(foregroundStyle)
                        .animation(animation, value: currentDestination)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.horizontal, 8)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(currentDestination == des ? Colors.accent : .clear)
                            .animation(animation, value: currentDestination)
                    )
                }
            }
        } detail: {
            switch currentDestination {
            case .home: HomeView()
            default: Text("The content goes here.")
            }
        }
        .navigationTitle(currentDestination.title)
    }
}

#Preview {
    @Previewable @State var des: Destination = .home
    
    macOSMainView(currentDestination: $des)
}
