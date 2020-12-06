//
//  FakeNetworkRequest.swift
//  FloweryTests
//

import Foundation

@testable import Flowery

final class FakeNetworkRequest: NetworkRequest, Encodable {

    typealias ResponseType = EmptyResponse

    var simulatedMethod: RequestMethod?
    var simulatedPath: String?
    var simulatedQuery: String?

    var method: RequestMethod {
        simulatedMethod ?? .GET
    }

    var path: String {
        simulatedPath ?? "/path"
    }

    var query: String? {
        simulatedQuery
    }

    enum CodingKeys: CodingKey {
        case test
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode("test", forKey: .test)
    }
}

extension RequestMethod: Encodable {}
