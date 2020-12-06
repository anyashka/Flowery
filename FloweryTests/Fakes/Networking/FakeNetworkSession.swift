//
//  FakeNetworkSession.swift
//  FloweryTests
//

import Foundation

@testable import Flowery

final class FakeNetworkSession: NetworkSession {

    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    var tasksCompletion: (([URLSessionTask]) -> Void)?
    var simulatedActiveTasks = [FakeURLSessionDataTask]()
    var requestPassed: URLRequest?
    var URLPassed: URL?
    var currentDataTask: FakeURLSessionDataTask?

    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        requestPassed = request
        self.completionHandler = completionHandler
        currentDataTask = FakeURLSessionDataTask()
        return currentDataTask!
    }

    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        URLPassed = url
        self.completionHandler = completionHandler
        currentDataTask = FakeURLSessionDataTask()
        return currentDataTask!
    }

    func getAllTasks(completionHandler: @escaping ([URLSessionTask]) -> Void) {
        self.tasksCompletion = completionHandler
    }

    func simulateGotTasks() {
        tasksCompletion?(simulatedActiveTasks)
    }

    func simulateResponse(data: Data?, response: URLResponse) {
        completionHandler?(data, response, nil)
    }

    func simulateFailure(error: Error) {
        completionHandler?(nil, nil, error)
    }
}
