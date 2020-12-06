//
//  Localizable.swift
//  Flowery
//

import Foundation

// MARK: Localizable

enum Localizable {

    enum General {

        static let ok = localized("general.ok")

        enum Error {
            static let somethingWrongTitle = localized("general.error.something-went-wrong.title")
            static let somethingWrongMessage = localized("general.error.something-went-wrong.message")
        }
    }

    enum ProductList {
        static let nagivationBarTitle = localized("product.list.navigation-title")
        static let noData = localized("product.list.no-data")
    }

    enum ProductDetail {
        static let noImageData = localized("product.detail.no-image-data")
    }
}

// MARK: Localization Helper

/// Returns localized string.
///
/// SeeAlso: `NSLocalizedString.init`
func localized(
    _ identifier: String,
    tableName: String? = nil,
    bundle: Bundle = Bundle.main,
    value: String = "",
    comment: String = ""
) -> String {
    NSLocalizedString(identifier, tableName: tableName, bundle: bundle, value: value, comment: comment)
}
