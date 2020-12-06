//
//  DefaultNetworkControllerTests.swift
//  FloweryTests
//

import Foundation
import XCTest

@testable import Flowery

final class DefaultNetworkControllerTests: XCTestCase {

    var sut: DefaultNetworkController!
    var fakeRequestBuilder: FakeRequestBuilder!
    var fakeNetworkSession: FakeNetworkSession!
    
    override func setUp() {
        fakeRequestBuilder = FakeRequestBuilder(scheme: .http, host: "test.com")
        fakeNetworkSession = FakeNetworkSession()
        sut = DefaultNetworkController(
            requestBuilder: fakeRequestBuilder,
            session: fakeNetworkSession
        )
    }

    func testShouldReturnEmptyResponse() {
        // given:
        let fakeRequest = FakeNetworkRequest()

        // when:
        sut.perform(request: fakeRequest) { result in

            // then:
            switch result {
            case .success:
                break
            case .failure:
                XCTFail("Should return successfully parsed result")
            }
        }
        fakeNetworkSession.simulateResponse(data: Data(), response: HTTPURLResponse(url: URL(string: "fixture.url")!, statusCode: 200, httpVersion: nil, headerFields: nil)!)
    }

    func testShouldReturnNetworkError() {
        // given:
        let fakeRequest = FakeNetworkRequest()
        let fixtureError = NSError(domain: "", code: 404, userInfo: nil)

        // when:
        sut.perform(request: fakeRequest) { result in

            // then:
            switch result {
            case .success:
                XCTFail("Should return network error")
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.notFound, "Should return not found error")
            }
        }
        fakeNetworkSession.simulateFailure(error: fixtureError)
    }

    func testShouldReturnDescribedNetworkError() {
        // given:
        let fakeRequest = FakeNetworkRequest()
        let fixtureDescription = "description"
        let fixtureError = NSError(domain: "", code: 40004, userInfo: [NSLocalizedDescriptionKey: fixtureDescription])

        // when:
        sut.perform(request: fakeRequest) { result in

            // then:
            switch result {
            case .success:
                XCTFail("Should return network error")
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.describedError(description: fixtureDescription), "Should return described error error")
            }
        }
        fakeNetworkSession.simulateFailure(error: fixtureError)
    }

    func testShouldReturnNoDataError() {
        // given:
        let fakeRequest = FakeNetworkRequest()

        // when:
        sut.perform(request: fakeRequest) { result in

            // then:
            switch result {
            case .success:
                XCTFail("Should return network error")
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.noData, "Should return no data error error")
            }
        }
        fakeNetworkSession.simulateResponse(data: nil, response: HTTPURLResponse(url: URL(string: "fixture.url")!, statusCode: 200, httpVersion: nil, headerFields: nil)!)
    }

    func testShouldReturnNoNetworkErrorIfErrorCodeInResponse() {
        // given:
        let fakeRequest = FakeNetworkRequest()

        // when:
        sut.perform(request: fakeRequest) { result in

            // then:
            switch result {
            case .success:
                XCTFail("Should return network error")
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.forbidden, "Should return forbidden error error")
            }
        }
        fakeNetworkSession.simulateResponse(data: Data(), response: HTTPURLResponse(url: URL(string: "fixture.url")!, statusCode: 403, httpVersion: nil, headerFields: nil)!)
    }


    func testShouldCancelPendingTasks() {
        // when:
        sut.cancelPendingRequests()
        fakeNetworkSession.simulateGotTasks()

        // then:
        fakeNetworkSession.simulatedActiveTasks.forEach {
            XCTAssertNotNil($0.storage["cancel"], "Should cancel all pending tasks")
        }
    }
}
