//
//  FakeURLSessionDataTask.swift
//  FloweryTests
//

import Foundation

final class FakeURLSessionDataTask: URLSessionDataTask {
    var storage: [String: Int] = [:]

    override func resume() {
        if let numberOfCalls = storage["resume"] {
            storage["resume"] = numberOfCalls + 1
        } else {
            storage["resume"] = 1
        }
    }

    override func cancel() {
        if let numberOfCalls = storage["cancel"] {
            storage["cancel"] = numberOfCalls + 1
        } else {
            storage["cancel"] = 1
        }
    }
}
