//
//  JSONDataTaskDownloader.swift
//  iOSTestTemplate
//
//  Created by Param Veghal on 23/09/2020.
//  Copyright © 2020 Param Veghal. All rights reserved.
//

import Foundation

final class JSONDataTaskDownloader: JSONDataTaskDownloaderType {

    typealias JSONDataTaskCompletionResult = (Result<Data, NetworkError>)
    typealias JSONDataTaskCompletionHandler = (JSONDataTaskCompletionResult) -> Void

    private let session: URLSessionType

    init(session: URLSessionType = URLSession.shared) {
        self.session = session
    }

    func jsonTask(with request: URLRequest, completion: @escaping JSONDataTaskCompletionHandler) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let response = response as? HTTPURLResponse else {
                    if let error = error as? URLError {
                        // HANDLE ERROR
                    }
                    return
                }

                if let data = data {
                    // HANDLE COMPLETION
                } else if let error = error {
                    // HANDLE COMPLETION
                } else {
                    // HANDLE COMPLETION
                }
            }
        }
        return task
    }
}

