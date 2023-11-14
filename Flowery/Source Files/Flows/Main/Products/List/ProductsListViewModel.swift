//
//  ProductsListViewModel.swift
//  Flowery
//

import Foundation

/// A view model for products list view controller.
protocol ProductsListViewModel: AnyObject {

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

/// A default products list view model.
final class DefaultProductsListViewModel: ProductsListViewModel {

    // MARK: Properties

    /// - SeeAlso: `ProductsListViewModel.onProductsFetch`
    var onProductsFetch: (([Product]) -> Void)?

    /// - SeeAlso: `ProductsListViewModel.onNetworkError`
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

    /// - SeeAlso: `ProductsListViewModel.fetchInitialPage`
    func fetchProducts() {
        productsNetworkController.fetchProducts { [weak self] result in
            guard let self = self else { return }
            log("ProductsListViewModel:fetchProducts - fetching products")
            switch result {
            case .success(let productResult):
                self.currentProducts = productResult.products
                self.onProductsFetch?(self.currentProducts)
            case .failure(let error):
                logError("ProductsListViewModel:fetchProducts - Failed to fetch items with error: \(error.localizedDescription)")
                self.onNetworkError?(error)
            }
        }
    }

    /// - SeeAlso: `ProductsListViewModel.imageURL`
    func imageURL(for product: Product) -> URL? {
        let noImageFoundURL = "https://st4.depositphotos.com/14953852/22772/v/450/depositphotos_227724992-stock-illustration-image-available-icon-flat-vector.jpg"
        return URL(string: product.image?.thumbnailURL ?? noImageFoundURL)
    }
}
