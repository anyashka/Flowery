//
//  UINavigationBarApp.swift
//  Flowery
//

import UIKit

extension UINavigationBar {

    /// Sets a default app style for the bar.
    static func setAppAppearance() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .appDarkGreen
        navigationBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.appBeige
        ]
        UINavigationBar.appearance().tintColor = .appBeige
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
}
