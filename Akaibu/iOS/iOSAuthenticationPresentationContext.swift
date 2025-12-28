//
//  iOSAuthenticationPresentationContext.swift
//  Akaibu
//
//  Created by kite1412 on 28/12/25.
//

#if os(iOS)
import UIKit
import AuthenticationServices

class iOSAuthenticationPresentationContext: NSObject, ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first!
    }
}

#endif
