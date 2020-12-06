//
//  DefaultPopularProductsViewModelTests.swift
//  FloweryTests
//

import Foundation
import XCTest

@testable import Flowery

final class DefaultPopularProductsViewModelTests: XCTestCase {

    var sut: DefaultPopularProductsViewModel!
    var fakeProductsNetworkController: FakeProductsNetworkController!

    override func setUp() {
        fakeProductsNetworkController = FakeProductsNetworkController()
        sut = DefaultPopularProductsViewModel(productsNetworkController: fakeProductsNetworkController)
    }

    func testFetchingProductsSuccessfully() {
        // given:
        let fixtureProducts: [Product] = []
        let fixtureResult = ProductsResult(products: fixtureProducts)
        var productsReceived: [Product]?
        sut.onProductsFetch = { products in
            productsReceived = products
        }

        // when:
        sut.fetchProducts()
        fakeProductsNetworkController.simulateSuccess(result: fixtureResult)

        // then:
        XCTAssertEqual(productsReceived, fixtureProducts, "Should return received products in a callback")
    }

    func testShouldReturnErrorOnFailedAPIResponse() {
        // given:
        let fixtureError = NetworkError.noData
        var errorReceived: NetworkError?
        sut.onNetworkError = { error in
            errorReceived = error
        }

        // when:
        sut.fetchProducts()
        fakeProductsNetworkController.simulateError(fixtureError)

        // then:
        XCTAssertEqual(errorReceived, fixtureError, "Should return received error in a callback")
    }
}
