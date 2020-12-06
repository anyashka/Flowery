//
//  DefaultImageCache.swift
//  Flowery
//

import UIKit

/// A default image cache using NSCache.
final class DefaultImageCache: ImageCache {

    private let cache = NSCache<NSURL, UIImage>()

    /// - SeeAlso: `ImageCache.setImage`
    func setImage(_ image: UIImage, for URL: URL) {
        cache.setObject(image, forKey: URL as NSURL)
    }

    /// - SeeAlso: `ImageCache.getImage`
    func getImage(for URL: URL) -> UIImage? {
        cache.object(forKey: URL as NSURL)
    }
}
