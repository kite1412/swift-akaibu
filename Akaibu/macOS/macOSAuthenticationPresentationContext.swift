//
//  macOSAuthenticationPresentationContext.swift
//  Akaibu
//
//  Created by kite1412 on 28/12/25.
//

#if os(macOS)
import AuthenticationServices

class macOSAuthenticationPresentationContext: NSObject, ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        NSApplication.shared.windows.first!
    }
}

#endif
