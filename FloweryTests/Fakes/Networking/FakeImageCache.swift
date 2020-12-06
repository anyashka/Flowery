//
//  FakeImageCache.swift
//  FloweryTests
//

import UIKit

@testable import Flowery

final class FakeImageCache: ImageCache {

    var simulatedCache: [URL: UIImage] = [:]

    func setImage(_ image: UIImage, for URL: URL) {
        simulatedCache[URL] = image
    }

    func getImage(for URL: URL) -> UIImage? {
        simulatedCache[URL]
    }
}
