//
//  DefaultImageDownloaderTests.swift
//  FloweryTests
//

import Foundation
import XCTest

@testable import Flowery

final class DefaultImageDownloaderTests: XCTestCase {

    var sut: DefaultImageDownloader!
    var fakeSession: FakeNetworkSession!
    var fakeImageCache: FakeImageCache!

    override func setUp() {
        fakeSession = FakeNetworkSession()
        fakeImageCache = FakeImageCache()
        sut = DefaultImageDownloader(networkSession: fakeSession, imageCache: fakeImageCache)
    }

    func testShouldReturnImageFromCacheIfAny() {
        // given:
        let fixtureImage = UIImage()
        let fixtureURL = URL(string: "fixture")!
        fakeImageCache.simulatedCache = [fixtureURL: fixtureImage]

        // when:
        sut.download(with: fixtureURL) { result in

            // then:
            switch result {
            case .success(let image):
                XCTAssertEqual(image, fixtureImage, "Should return image from cache")
            case .failure:
                XCTFail("Should not fail")
            }
        }
    }

    func testShoudDownloadImageIfNoInCache() {
        // given:
        let fixtureURL = URL(string: "fixture")!
        fakeImageCache.simulatedCache = [:]
        let fixtureImage = UIImage.makeImage(withColor: .black)!
        let fixtureData = fixtureImage.pngData()

        // when:
        sut.download(with: fixtureURL) { result in

            // then:
            switch result {
            case .success(let image):
                XCTAssertEqual(image.pngData(), fixtureData, "Should download image")
            case .failure:
               XCTFail("Should not fail")
           }
        }
        fakeSession.simulateResponse(data: fixtureData, response: .init())
    }

    func testShouldReturnFailureOnDownloadFail() {
        // given:
        let fixtureURL = URL(string: "fixture")!
        fakeImageCache.simulatedCache = [:]

        // when:
        sut.download(with: fixtureURL) { result in

            // then:
            switch result {
            case .success:
                XCTFail("Should not return success")
           case .failure(let error):
               XCTAssertEqual(error, ImageDownloaderError.failed, "Should return failure")
           }
        }
        fakeSession.simulateFailure(error: ImageDownloaderError.failed)
    }

    func testShouldCancelTaskForUUID() {
        // given:
        let fixtureURL = URL(string: "fixture")!

        // when:
        let resultUUID = sut.download(with: fixtureURL) { _ in }
        sut.cancelTask(for: resultUUID!)

        // then:
        XCTAssertEqual(fakeSession.currentDataTask?.storage["cancel"], 1, "Should call cancel for a task")
    }
}

extension UIImage {

    /// Creates an image of a desired size, filled with a provided color.
    ///
    /// - Parameters:
    ///   - color: an image color.
    ///   - size: an image size.
    /// - Returns: an image, filled with a provided color.
    class func makeImage(withColor color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
