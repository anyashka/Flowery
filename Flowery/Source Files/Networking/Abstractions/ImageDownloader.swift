//
//  ImageDownloader.swift
//  NetworkingKit
//

import UIKit

enum ImageDownloaderError: Error {
    case failed
}

/// Convenience wrapper for URL Session.
protocol ImageDownloader: AnyObject {

    /// Downloads an image.
    /// - Parameters:
    ///   - url: a URL for downloading.
    ///   - completionHandler: a callback to execute when network call is completed.
    /// - Returns: UUID id in case of new request creation or nil when the image was take out of cache.
    @discardableResult func download(with url: URL, completionHandler: @escaping (Result<UIImage, ImageDownloaderError>) -> Void) -> UUID?

    /// Cancels chosen task.
    /// - Parameter completionHandler: callback on which active tasks are returned.
    func cancelTask(for UUID: UUID)
}

