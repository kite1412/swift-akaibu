//
//  LoginView.swift
//  Akaibu
//
//  Created by kite1412 on 27/12/25.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack(spacing: 24) {
            HStack(spacing: 8) {
                let imageSize: CGFloat = 48
                
                Image(Images.appIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: imageSize)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(
                                LinearGradient(
                                    gradient: Gradient(colors: [.red, .blue]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1
                            )
                    )
                VStack(alignment: .leading, spacing: 0) {
                    Text("Let's get you")
                        .italic()
                    HStack(spacing: 0) {
                        Text("into ")
                            .italic()
                        Text("Akaibu")
                            .italic()
                            .fontWeight(.bold)
                        Text("!")
                            .italic()
                    }
                }
            }
            VStack(alignment: .leading) {
                Text("Login with:")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundStyle(.gray)
                Button {
                    
                } label: {
                    Label {
                        Text("MyAnimeList account")
                    } icon: {
                        Image(Images.malLogo)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 24)
                            .padding(8)
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.blue, lineWidth: 1)
                        .background(.thinMaterial)
                )
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    LoginView()
}
