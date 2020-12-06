//
//  DependencyProvider.swift
//  Flowery
//

import Foundation

// MARK: DependencyProvider

/// An abstraction providing convenient reference to all major app dependencies.
protocol DependencyProvider: AnyObject {

    /// A controller used for fetching products.
    var productsNetworkController: ProductsNetworkController { get }

    /// Image downloading & caching service.
    var imageDownloader: ImageDownloader { get }
}

// MARK: DefaultDependencyProvider

/// An default app dependencies provider.
final class DefaultDependencyProvider: DependencyProvider {

    /// - SeeAlso: `DependencyProvider.productsNetworkController`
    let productsNetworkController: ProductsNetworkController

    /// - SeeAlso: `DependencyProvider.imageDownloader`
    let imageDownloader: ImageDownloader

    /// A default initializer for dependency provider.
    init() {
        let networkSession = URLSession(configuration: .default)
        let requestBuilder = DefaultRequestBuilder(scheme: .https, host: "api.bloomandwild.com")
        let networkController = DefaultNetworkController(requestBuilder: requestBuilder, session: networkSession)
        productsNetworkController = DefaultProductsNetworkController(networkController: networkController)
        let imageCache = DefaultImageCache()
        imageDownloader = DefaultImageDownloader(networkSession: networkSession, imageCache: imageCache)
    }
}
