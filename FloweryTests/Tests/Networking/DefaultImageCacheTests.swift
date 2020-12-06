//
//  DefaultImageCacheTests.swift
//  FloweryTests
//

import Foundation
import XCTest

@testable import Flowery

final class DefaultImageCacheTests: XCTestCase {

    var sut: DefaultImageCache!

    override func setUp() {
        sut = DefaultImageCache()
    }

    func testSettingAndGettingImage() {
        // given:
        let fixtureURL = URL(string: "test")!
        let fixtureImage = UIImage.makeImage(withColor: .black)!

        // when:
        sut.setImage(fixtureImage, for: fixtureURL)
        let result = sut.getImage(for: fixtureURL)

        // then:
        XCTAssertEqual(result, fixtureImage, "Should return same image for the url")
    }
}
