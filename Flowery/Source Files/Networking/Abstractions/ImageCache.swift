//
//  ImageCache.swift
//  NetworkingKit
//

import UIKit

/// An image cache abstraction.
protocol ImageCache: AnyObject {

    /// Setting an image with it's URL as a key.
    ///
    /// - Parameters:
    ///     - image: an image to be cached.
    ///     - URL: image URL to be set as a key.
    func setImage(_ image: UIImage, for URL: URL)

    /// Getting an image for it's URL
    ///
    /// - Parameter URL: image URL to be used as a key.
    /// - Returns: image if any.
    func getImage(for URL: URL) -> UIImage?
}
