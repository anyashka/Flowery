//
//  DefaultPopularProductsViewControllerTests.swift
//  FloweryTests
//

import Foundation
import XCTest

@testable import Flowery

final class PopularProductsViewControllerTests: XCTestCase {

    var sut: PopularProductsViewController!
    var fakeViewModel: FakePopularProductsViewModel!
    var fakeInfoAlert: FakeInfoAlert!

    override func setUp() {
        fakeViewModel = FakePopularProductsViewModel()
        fakeInfoAlert = FakeInfoAlert()
        let imageDownloader = DefaultImageDownloader(networkSession: URLSession.shared, imageCache: DefaultImageCache())
        sut = PopularProductsViewController(viewModel: fakeViewModel, imageDownloader: imageDownloader, infoAlert: fakeInfoAlert)
    }

    func testShouldFetchDataOnViewDidLoad() {
        // when:
        sut.loadViewIfNeeded()

        // then:
        XCTAssertTrue(fakeViewModel.fetchProductsCalled, "Should fetch products")
    }

    func testShouldUpdateTableViewWithEmptyStateIfNoDataAvailable() {
        // given:
        let fixtureProducts: [Product] = []

        // when:
        sut.loadViewIfNeeded()
        fakeViewModel.onProductsFetch?(fixtureProducts)

        // then:
        XCTAssertEqual(sut.customView.tableView.backgroundView, sut.customView.emptyTableViewLabel, "Should update table view for empty state")
    }

    func testShowDataWhenAPIReturns() {
        // given:
        let fixtureAttributes = ProductAttributes(
            name: "Flowers",
            collectionName: "collection",
            fullPrice: 28.0,
            discountedPrice: 28.0,
            currencyCode: "GPB",
            description: "Descibing",
            media: [ProductMedia(url: "url")],
            ratingAverage: nil,
            ratingCount: nil)
        let fixtureProducts = [Product(id: "1", attributes: fixtureAttributes)]

        // when:
        sut.loadViewIfNeeded()
        fakeViewModel.onProductsFetch?(fixtureProducts)

        // then:
        XCTAssertNil(sut.customView.tableView.backgroundView, "Should remove background view on data received")
        XCTAssertEqual(sut.customView.tableView.numberOfRows(inSection: 0), fixtureProducts.count, "Should update table view with data")
        guard let cell = sut.tableView(sut.customView.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? ProductTableViewCell else {
            XCTFail("Should render product cells in table view")
            return
        }
        XCTAssertEqual(cell.nameLabel.text, fixtureAttributes.name, "Should set user id from view model data")
        XCTAssertEqual(cell.priceLabel.text, NumberFormatter.getAmountPriceText(for: fixtureProducts[0]), "Should set user id from view model data")
    }

    func testShouldShowErrorAlertOnNetworkingError() {
        // given:
        let fixtureError = NetworkError.forbidden

        // when:
        sut.loadViewIfNeeded()
        fakeViewModel.onNetworkError?(fixtureError)

        // then:
        XCTAssertEqual(fakeInfoAlert.lastReceivedInfo, [Localizable.General.Error.somethingWrongTitle, Localizable.General.Error.somethingWrongMessage], "Should show error alert")
    }
}

