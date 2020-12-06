//
//  DefaultRequestBuilderTests.swift
//  FloweryTests
//

import Foundation
import XCTest

@testable import Flowery

final class DefaultRequestBuilderTests: XCTestCase {

    var sut: DefaultRequestBuilder!
    var fakeScheme: Scheme!
    var fakeURLHost: String!

    override func setUp() {
        fakeScheme = .http
        fakeURLHost = "fake.com"
        sut = DefaultRequestBuilder(scheme: fakeScheme, host: fakeURLHost)
    }

    func testShouldCreateRightURLFromRequest() {
        // given:
        let fixtureHTTPMethod: RequestMethod = .GET
        let fixturePath = "/fixture"
        let fakeRequest = FakeNetworkRequest()
        fakeRequest.simulatedMethod = fixtureHTTPMethod
        fakeRequest.simulatedPath = fixturePath

        // when:
        let resultURLRequest = sut.prepare(fakeRequest)

        // then:
        XCTAssertEqual(resultURLRequest.httpMethod, fixtureHTTPMethod.rawValue, "Should use given http method")
        XCTAssertEqual(resultURLRequest.url?.absoluteString, fakeScheme.rawValue + "://" + fakeURLHost + fixturePath, "Should build request url from given data")
    }

    func testShouldEncodeParametersForPostRequest() {
        // given:
        let fixtureHTTPMethod: RequestMethod = .POST
        let fakeRequest = FakeNetworkRequest()
        fakeRequest.simulatedMethod = fixtureHTTPMethod
        let expectedData = try! JSONEncoder().encode(["test": "test"])

        // when:
        let resultURLRequest = sut.prepare(fakeRequest)

        XCTAssertEqual(resultURLRequest.httpBody, expectedData, "Should serialize request parameters.")
    }
}
