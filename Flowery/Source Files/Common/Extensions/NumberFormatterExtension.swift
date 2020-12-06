//
//  NumberFormatterExtension.swift
//  Flowery
//
//  Copyright © 2020 Anna-Mariia Shkarlinska. All rights reserved.
//

import Foundation

extension NumberFormatter {

    /// A currency style number formatter.
    static let currencyFormatter: NumberFormatter = makeCurrencyFormatter()

    /// Makes a currency number formatter.
    ///
    /// - Parameter currencyCode: A code to be used for the currency formatter.
    static func makeCurrencyFormatter(with currencyCode: String) -> NumberFormatter {
        let numberFormatter = makeCurrencyFormatter()
        numberFormatter.currencyCode = currencyCode
        return numberFormatter
    }

    /// Returns a formatted amount with currency text for product.
    ///
    /// - Parameter product: A product for which the text should be counted.
    /// - Returns: a formatted text or empty if it couldn't be formatted.
    static func getAmountPriceText(for product: Product) -> String {
        getAmountCurrencyText(
            for: product.attributes.fullPrice,
            currencyCode: product.attributes.currencyCode
        )
    }

    /// Returns a formatted amount with currency text for transaction.
    ///
    /// - Parameters:
    ///     - amount: An amount which should be formatted.
    ///     - currencyCode: A currency code to be included in the formatted text.
    /// - Returns: a formatted text or empty if it couldn't be formatted.
    static func getAmountCurrencyText(for amount: Double, currencyCode: String) -> String {
        currencyFormatter.currencyCode = currencyCode
        return currencyFormatter.getText(from: amount)
    }
}

private extension NumberFormatter {

    static func makeCurrencyFormatter() -> NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter
    }

    func getText(from amount: Double) -> String {
        if let text = string(for: amount) {
            return text
        } else {
            log("NumberFormatter:getText - failed to create")
            return ""
        }
    }
}
