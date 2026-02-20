//
//  View+Utilities.swift
//  Akaibu
//
//  Created by kite1412 on 20/02/26.
//

import SwiftUI

extension View {
    @ViewBuilder
    func applyIf<T: View>(_ condition: Bool, transform: (Self) -> T) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
