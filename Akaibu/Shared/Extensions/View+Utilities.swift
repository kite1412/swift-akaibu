//
//  View+Utilities.swift
//  Akaibu
//
//  Created by kite1412 on 20/02/26.
//

import SwiftUI

extension View {
    @ViewBuilder
    func applyIf<T: View>(_ condition: Bool, @ViewBuilder transform: (Self) -> T) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    @ViewBuilder
    func logoutAlert(showAlert: Binding<Bool>, onConfirm: @escaping () -> Void) -> some View {
        alert("Are you sure you want to logout?", isPresented: showAlert) {
            Button("Cancel", role: .cancel) {
                showAlert.wrappedValue = false
            }
            Button("Logout", role: .destructive) {
                onConfirm()
                showAlert.wrappedValue = false
            }
        } message: {
            Text("You need to log in again to access the app.")
        }
    }
}
