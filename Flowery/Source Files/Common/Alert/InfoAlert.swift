//
//  InfoAlert.swift
//  Flowery
//

import UIKit

/// Describes the info alert logic.
protocol InfoAlert: AnyObject {
    
    /// Presents an alert view controller on the specified view controller.
    ///
    /// - Parameters:
    ///     - viewController: A view controller on which alert should be presented.
    ///     - title: A title to be shown on the alert view controller.
    ///     - message: A message to be shown on the alert view controller.
    ///     - buttonTitle: A title on the acceptance button.
    ///     - completion: The block to execute after the presentation finishes and user click on a button.
    func show(
        on viewController: UIViewController,
        title: String,
        message: String?,
        buttonTitle: String,
        acceptanceCompletion: (() -> Void)?)
}

// MARK: Default Implementation

extension InfoAlert {

    /// - SeeAlso: `InfoAlert.show`
    func show(
        on viewController: UIViewController,
        title: String,
        message: String?,
        acceptanceCompletion: (() -> Void)?) {
        show(on: viewController, title: title, message: message, buttonTitle: Localizable.General.ok, acceptanceCompletion: acceptanceCompletion)
    }
}

/// Constructing and presenting informational alert.
final class DefaultInfoAlert: InfoAlert {

    /// - SeeAlso: `InfoAlert.show`
    func show(
        on viewController: UIViewController,
        title: String,
        message: String?,
        buttonTitle: String = Localizable.General.ok,
        acceptanceCompletion: (() -> Void)?) {
        let okAction = UIAlertAction(title: buttonTitle, style: .default, handler: { _ in
            acceptanceCompletion?()
        })
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
