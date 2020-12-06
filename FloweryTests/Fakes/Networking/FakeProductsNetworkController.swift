//
//  FakeProductsNetworkController.swift
//  FloweryTests
//

import Foundation
@testable import Flowery

final class FakeProductsNetworkController: ProductsNetworkController {

    var completionHandler: ((Result<ProductsResult, NetworkError>) -> Void)?

    func fetchProducts(completion: @escaping (Result<ProductsResult, NetworkError>) -> Void) {
        completionHandler = completion
    }
    func simulateSuccess(result: ProductsResult) {
        completionHandler?(.success(result))
    }

    func simulateError(_ error: NetworkError) {
        completionHandler?(.failure(error))
    }
}
