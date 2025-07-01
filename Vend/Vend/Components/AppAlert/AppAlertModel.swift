//
//  AppAlertModel.swift
//  Vend
//
//  Created by Can Kurtur on 2025-07-01.
//

/// A model representing an alert with a title, message, button title, and an optional action.
/// This can be used to configure alerts dynamically across the app.
public struct AlertModel {
    public let title: String?
    public let message: String
    public let buttonTitle: String?
    public let buttonAction: (() -> Void)?
    
    /// Initializes an `AlertModel` with the given parameters.
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: The message content of the alert.
    ///   - buttonTitle: The title of the alert button.
    ///   - buttonAction: An optional action to be executed when the button is tapped.
    public init(
        title: String? = nil,
        message: String,
        buttonTitle: String? = nil,
        buttonAction: (() -> Void)? = nil)
    {
        self.title = title
        self.message = message
        self.buttonTitle = buttonTitle
        self.buttonAction = buttonAction
    }
}
