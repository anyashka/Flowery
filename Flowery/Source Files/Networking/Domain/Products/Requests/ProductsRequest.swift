//
//  ProductsRequest.swift
//  Flowery
//

import Foundation

struct ProductsRequest: NetworkRequest {
    
    typealias ResponseType = ProductsResult

    var path: String {
        "/api/species-list"
    }

    // in production application with lots of requests
    // would be better to append key in a reusable way
    var query: String? {
        "key=\(Constants.apiKey)&page=1&indoor=1"
    }
}
