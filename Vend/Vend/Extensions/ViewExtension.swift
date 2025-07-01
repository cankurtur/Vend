//
//  ViewExtension.swift
//  Vend
//
//  Created by Can Kurtur on 2025-07-01.
//

import SwiftUI

/// A custom view modifier extension to present an alert based on an `AlertModel` and a binding to a boolean value.
public extension View {
    /// A modifier that adds an alert to the view.
        /// - Parameters:
        ///   - isPresented: A binding to a boolean value that determines whether the alert is shown.
        ///   - alertModel: The `AlertModel` containing the alert details (title, message, button, and action).
        /// - Returns: A view with the alert applied based on the provided `alertModel`.
    func appAlert(isPresented: Binding<Bool>, alertModel: AlertModel?) -> some View {
        self.modifier(AppAlertModifier(isPresented: isPresented, alertModel: alertModel))
    }
}
