//
//  NetworkSession.swift
//  Flowery
//

import Foundation

/// Convenience wrapper for URL Session.
protocol NetworkSession: AnyObject {

    /// Creates URL Session Data Task wrapped.
    /// - Parameters:
    ///   - request: a URL request.
    ///   - completionHandler: a callback to execute when network call is completed.
    /// - Returns: URL data task.
    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask

    /// Creates URL Session Data Task wrapped.
    /// - Parameters:
    ///   - url: a URL.
    ///   - completionHandler: a callback to execute when network call is completed.
    /// - Returns: URL data task.
    func dataTask(with url: URL, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask

    /// Gathers all active tasks
    /// - Parameter completionHandler: callback on which active tasks are returned.
    func getAllTasks(completionHandler: @escaping @Sendable ([URLSessionTask]) -> Void)
}

extension URLSession: NetworkSession {}
