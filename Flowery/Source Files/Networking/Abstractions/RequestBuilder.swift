//
//  NetworkRequestBuilder.swift
//  Flowery
//

import Foundation

/// Base chemes for the requests.
enum Scheme: String {
    case http
    case https
}

/// Interface for objects used to create API request configuration.
protocol RequestBuilder {

    /// Initializes a new instance of RequestBuilder.
    /// - Parameters:
    ///     - scheme: a scheme indicating whether configuration should use http or https.
    ///     - host: base URL to the API.
    /// - SeeAlso: Scheme
    init(scheme: Scheme, host: String)

    /// Prepare a URLRequest from API request.
    /// - Parameter request: APIRequest to create a URLRequest from.
    /// - Returns: URLRequest that can be passed exactly to URLSession.
    /// - SeeAlso: APIRequest
    func prepare<Request: NetworkRequest>(_ request: Request) -> URLRequest
}
