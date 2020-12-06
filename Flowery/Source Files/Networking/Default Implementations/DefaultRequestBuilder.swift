//
//  DefaultRequestBuilder.swift
//  NetworkingKit
//

import Foundation

/// A default request builder.
final class DefaultRequestBuilder: RequestBuilder {

    /// Dafult timeout for all requests.
    private let defaultTimeoutInterval: TimeInterval = 30

    /// URL scheme determining whether use http or https.
    /// - SeeAlso: Scheme
    private let scheme: Scheme

    /// Base API host.
    private let host: String

    /// Computed property returning base url components to be appended with path.
    private var baseComponents: URLComponents {
        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.host = host
        return components
    }

    /// - SeeAlso: `RequestBuilder.init`
    init(scheme: Scheme, host: String) {
        self.scheme = scheme
        self.host = host
    }

    /// - SeeAlso: `RequestBuilder.prepare`
    func prepare<Request: NetworkRequest>(_ request: Request) -> URLRequest {
        var components = baseComponents
        components.path = request.path
        components.query = request.query
        var urlRequest = URLRequest(url: components.url!, timeoutInterval: defaultTimeoutInterval)
        if request.method != .GET {
            let httpBody = try? JSONEncoder().encode(request)
            urlRequest.httpBody = httpBody
        }
        urlRequest.httpMethod = request.method.rawValue
        return urlRequest
    }
}
