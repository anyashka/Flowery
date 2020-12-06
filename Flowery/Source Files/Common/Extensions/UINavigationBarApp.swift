//
//  UINavigationBarApp.swift
//  Flowery
//

import UIKit

extension UINavigationBar {

    /// Sets a default app style for the bar.
    func setAppStyle() {
        barTintColor = .appDarkGreen
        tintColor = .appCream
        titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.appCream
        ]
    }
}
