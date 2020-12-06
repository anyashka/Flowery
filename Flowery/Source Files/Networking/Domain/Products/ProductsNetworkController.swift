//
//  ProductsNetworkController.swift
//  Flowery
//

import Foundation

// MARK: ProductsNetworkController

/// A network controller for products information.
protocol ProductsNetworkController: AnyObject {

    /// Fetching products list.
    ///
    /// - Parameters:
    ///     - completion: Executed with a result of networking call - ProductsResult or NetworkError.
    func fetchProducts(completion: @escaping (Result<ProductsResult, NetworkError>) -> Void)
}

// MARK: DefaultProductsNetworkController

/// A default implementation of products network controller.
final class DefaultProductsNetworkController: ProductsNetworkController {

    private let networkController: NetworkController

    /// Initializes the default product network controller.
    ///
    /// - Parameter networkController: A network controller to be used for executing request.
    init(networkController: NetworkController) {
        self.networkController = networkController
    }

    /// - SeeAlso: `ProductsNetworkController.fetchProducts`
    func fetchProducts(completion: @escaping (Result<ProductsResult, NetworkError>) -> Void) {
        let request = ProductsRequest()
        networkController.perform(request: request, completion: completion)
    }
}
