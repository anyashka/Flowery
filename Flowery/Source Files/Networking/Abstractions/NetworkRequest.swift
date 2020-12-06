//
//  NetworkRequest.swift
//  NetworkingKit
//

import Foundation

protocol NetworkRequest: Encodable {

    /// Type of response, that request raw response should be parsed to. Should conform to Decodable protocol.
    associatedtype ResponseType: Decodable

    /// Indicates what HTTP method should be used for specified request.
    /// Defaults to .GET
    var method: RequestMethod { get }

    /// Path to selected resources in the API. Should not contain base URL, for example /tests/all.
    var path: String { get }

    /// Query used to prepare the request.
    var query: String? { get }
}

// MARK: Default implementation
extension NetworkRequest {
    
    var method: RequestMethod {
        .GET
    }

    var query: String? {
        nil
    }
}
