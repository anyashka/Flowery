//
//  FakeProductsListViewModel.swift
//  FloweryTests
//

import Foundation

@testable import Flowery

final class FakeProductsListViewModel: ProductsListViewModel {
    
    var onProductsFetch: (([Product]) -> Void)?

    var onNetworkError: ((NetworkError) -> Void)?

    var fetchProductsCalled = false

    var simulatedImageURL: URL?

    func fetchProducts() {
        fetchProductsCalled = true
    }

    func imageURL(for product: Product) -> URL? {
        simulatedImageURL
    }
}
