//
//  FakeRequestBuilder.swift
//  FloweryTests
//

import Foundation

@testable import Flowery

final class FakeRequestBuilder: RequestBuilder {

    let scheme: Scheme
    let host: String

    var simulatedURLRequest: URLRequest?
    var didCallPrepare = false

    init(scheme: Scheme, host: String) {
        self.scheme = scheme
        self.host = host
    }

    func prepare<Request>(_ request: Request) -> URLRequest where Request: NetworkRequest {
        didCallPrepare = true
        return simulatedURLRequest ?? URLRequest(url: URL(string: "http://test.com")!)
    }
}
