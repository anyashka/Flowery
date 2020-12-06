//
//  DefaultImageDownloader.swift
//  NetworkingKit
//

import UIKit

/// A default image downloader, which downloads images if needed and caches it.
final class DefaultImageDownloader: ImageDownloader {

    // MARK: Properties

    private var runningRequests = [UUID: URLSessionDataTask]()
    private let networkSession: NetworkSession
    private let imageCache: ImageCache

    // MARK: Intializers

    /// Initializes the image downloader.
    ///
    /// - Parameters:
    ///     - networkSession: a network session to be used for fetching images (URLSession wrapper).
    ///     - imageCache: an image cache to be used for minimalizing request sent.
    init(
        networkSession: NetworkSession,
        imageCache: ImageCache
    ) {
        self.networkSession = networkSession
        self.imageCache = imageCache
    }

    // MARK: Methods

    /// - SeeAlso: `ImageDownloader.download`
    @discardableResult func download(with url: URL, completionHandler: @escaping (Result<UIImage, ImageDownloaderError>) -> Void) -> UUID? {
        if let image = imageCache.getImage(for: url) {
           completionHandler(.success(image))
          return nil
        }
        let uuid = UUID()
        let task = networkSession.dataTask(with: url) { data, response, error in
            defer { self.runningRequests.removeValue(forKey: uuid) }
            if let data = data, let image = UIImage(data: data) {
                self.imageCache.setImage(image, for: url)
                completionHandler(.success(image))
                return
            } else {
                completionHandler(.failure(.failed))
            }
        }
        task.resume()
        runningRequests[uuid] = task
        return uuid
    }

    /// - SeeAlso: `ImageDownloader.cancelTask`
    func cancelTask(for UUID: UUID) {
        runningRequests[UUID]?.cancel()
        runningRequests.removeValue(forKey: UUID)
    }
}
