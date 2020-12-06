//
//  NetworkingTask.swift
//  NetworkingKit
//

import Foundation

/// An object allowing user to cancel an ongoing network call.
protocol NetworkTask {

    /// Starts network call.
    func resume()

    /// Cancels network call.
    func cancel()
}

extension URLSessionTask: NetworkTask {}
