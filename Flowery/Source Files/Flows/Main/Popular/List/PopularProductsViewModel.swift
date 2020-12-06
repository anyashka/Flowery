//
//  PopularProductsViewModel.swift
//  Flowery
//

import Foundation

/// A view model for popular products list view controller.
protocol PopularProductsViewModel: AnyObject {

    /// Executed when new product list received.
    var onProductsFetch: (([Product]) -> Void)? { get set }

    /// Executed when network error received.
    var onNetworkError: ((NetworkError) -> Void)? { get set }

    /// Fetching products.
    func fetchProducts()

    /// Return the best image URL for the product.
    ///
    /// - Parameter product: A product for which image URL should be returned.
    /// - Returns: an image URL if is one.
    func imageURL(for product: Product) -> URL?
}

/// A default popular products view model.
final class DefaultPopularProductsViewModel: PopularProductsViewModel {

    // MARK: Properties

    /// - SeeAlso: `PopularProductsViewModel.onProductsFetch`
    var onProductsFetch: (([Product]) -> Void)?

    /// - SeeAlso: `PopularProductsViewModel.onNetworkError`
    var onNetworkError: ((NetworkError) -> Void)?

    // MARK: Private Properties

    private let productsNetworkController: ProductsNetworkController

    private var currentProducts: [Product] = []

    // MARK: Initializers

    /// Initializes the view model.
    ///
    /// - Parameters:
    ///     - productsNetworkController: a network controller used for fetching products.
    init(productsNetworkController: ProductsNetworkController) {
        self.productsNetworkController = productsNetworkController
    }

    // MARK: Methods

    /// - SeeAlso: `PopularProductsViewModel.fetchInitialPage`
    func fetchProducts() {
        productsNetworkController.fetchProducts { [weak self] result in
            guard let self = self else { return }
            log("PopularProductsViewModel:fetchProducts - fetching products")
            switch result {
            case .success(let productResult):
                self.currentProducts = productResult.products
                self.onProductsFetch?(self.currentProducts)
            case .failure(let error):
                logError("PopularProductsViewModel:fetchProducts - Failed to fetch items with error: \(error.localizedDescription)")
                self.onNetworkError?(error)
            }
        }
    }

    /// - SeeAlso: `PopularProductsViewModel.imageURL`
    func imageURL(for product: Product) -> URL? {
        guard let image = product.attributes.media.first else { return nil }
        return URL(string: image.url)
    }
}
