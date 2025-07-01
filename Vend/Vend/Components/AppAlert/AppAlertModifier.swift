//
//  AppAlertModifier.swift
//  Vend
//
//  Created by Can Kurtur on 2025-07-01.
//

import SwiftUI

/// A custom view modifier that displays an alert when `isPresented` is `true`.
/// /// It uses the provided `AlertModel` to configure the alert's title, message, button, and action.
public struct AppAlertModifier: ViewModifier {
    @Binding var isPresented: Bool
    let alertModel: AlertModel?

    /// Applies the alert to the view content.
    /// - Parameters:
    ///   - content: The original view content that this modifier is applied to.
    /// - Returns: The content view with the alert applied.
    public func body(content: Content) -> some View {
        content
            .alert(
                alertModel?.title ?? Localizable.warning,
                   isPresented: $isPresented
            ) {
                Button(alertModel?.buttonTitle ?? Localizable.ok) {
                    alertModel?.buttonAction?()
                }
            } message: {
                Text(alertModel?.message ?? Localizable.empty)
            }
    }
}
