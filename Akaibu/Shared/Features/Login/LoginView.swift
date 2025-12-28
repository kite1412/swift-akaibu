//
//  LoginView.swift
//  Akaibu
//
//  Created by kite1412 on 27/12/25.
//

import SwiftUI
import AuthenticationServices
import OSLog

struct LoginView: View {
    private let auth = DIContainer.shared.authRemoteDataSource
    private var authPresentationContext: ASWebAuthenticationPresentationContextProviding {
        #if os(iOS)
        iOSAuthenticationPresentationContext()
        #else
        macOSAuthenticationPresentationContext()
        #endif
    }
    
    @ObservedObject var session: SessionManager
    @State private var loginInfo: String = "No action"
    @State private var loggingIn: Bool = false
    @State private var showError: Bool = false
    
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
            Text("Login status: \(loginInfo)")
            VStack(alignment: .leading) {
                Text("Login with:")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundStyle(.gray)
                Button {
                    initiateLogin()
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
        .overlay {
            if loggingIn {
                ProgressView {
                    Text("Logging in...")
                }
                .progressViewStyle(.circular)
                .transition(.opacity)
            }
        }
        .animation(.easeInOut, value: loggingIn)
        .alert("Login Failed", isPresented: $showError) {
            Button("Try Again", role: .confirm) {
                initiateLogin()
            }
        } message: {
            Text("Login failed. Please try again.")
        }
    }
    
    @MainActor
    private func login(authCode: String) async {
        loggingIn = true
        do {
            defer { loggingIn = false }
            loggingIn = true
            let token = try await auth.exchangeCode(authCode)
            
            debugOnly {
                AppLogger.auth.debug("token: \(token.accessToken)")
            }
            
            session.login(token: token.accessToken, refreshToken: token.refreshToken)
        } catch {
            self.loginInfo = "Fail to login"
        }
    }
    
    private func initiateLogin() {
        showError = false
        auth.requestCode(
            authPresentationContext,
            callback: { code in
                Task {
                    await login(authCode: code)
                }
            }
        )
    }
}

#Preview {
    LoginView(session: SessionManager())
}
