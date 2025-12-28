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
    @ObservedObject var session: SessionManager
    @State private var showLogoutConfirmation: Bool = false
    
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
                    .padding(8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(currentDestination == des ? Colors.accent : .clear)
                            .animation(animation, value: currentDestination)
                    )
                }
                
                Spacer()
                
                Button("Logout", systemImage: "rectangle.portrait.and.arrow.forward") {
                    showLogoutConfirmation = true
                }
                .frame(maxWidth: .infinity)
                .buttonSizing(.flexible)
                .padding()
                .foregroundStyle(.red)
            }
        } detail: {
            currentDestination.content
        }
        .navigationTitle(currentDestination.title)
        .alert("Are you sure you want to logout?", isPresented: $showLogoutConfirmation) {
            Button("Cancel", role: .cancel) {
                showLogoutConfirmation = false
            }
            Button("Logout", role: .destructive) {
                session.logout()
                showLogoutConfirmation = false
            }
        } message: {
            Text("You need to log in again to access the app.")
        }
    }
}

#Preview {
    @Previewable @State var des: Destination = .home
    
    macOSMainView(currentDestination: $des, session: SessionManager())
}
