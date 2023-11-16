//
//  ProductDetailsViewModel.swift
//  Flowery
//

import UIKit

// MARK: ProductDetailsViewModel

/// A view model for product details .
protocol ProductDetailsViewModel: AnyObject {

    /// Get images urls for the view.
    ///
    /// - Parameter product: A product for which image urls should be returned.
    /// - Returns: An array of urls if any.
    func getImagesURL(for product: Product) -> [URL]
}

// MARK: DefaultProductDetailsViewModel

/// A default product details view model.
final class DefaultProductDetailsViewModel: ProductDetailsViewModel {

    /// - SeeAlso: `ProductDetailsViewModel.getImagesURL`
    func getImagesURL(for product: Product) -> [URL] {
        // images are the same only differ in quality
        // this is done just to showcase the carousel
        [URL(string: product.image?.regularURL ?? ""), URL(string: product.image?.thumbnailURL ?? "")].compactMap { $0 }
    }
}
