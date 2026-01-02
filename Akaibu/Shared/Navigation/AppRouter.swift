//
//  AppRouter.swift
//  Akaibu
//
//  Created by kite1412 on 03/01/26.
//

import SwiftUI
import Combine

@MainActor
final class AppRouter: ObservableObject {
    @Published var path = NavigationPath()
    
    func goToMediaSearchResults(withTitle searchTitle: String) {
        path.append(StackDestination.mediaSearchResults(searchTitle: searchTitle))
    }
    
    private func navigate(to destination: StackDestination) {
        path.append(destination)
    }
}
