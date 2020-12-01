//
//  NetworkClient.swift
//  iOSTestTemplate
//
//  Created by Param Veghal on 23/09/2020.
//  Copyright © 2020 Param Veghal. All rights reserved.
//

import Foundation

typealias NetworkResponse<T> = Swift.Result<T, NetworkError>
typealias NetworkCompletion<T> = (NetworkResponse<T>) -> Void

final class NetworkClient: NetworkClientType {

    private let jsonDownloader: JSONDataTaskDownloaderType

    init(jsonDownloader: JSONDataTaskDownloaderType = JSONDataTaskDownloader()) {
        self.jsonDownloader = jsonDownloader
    }

    func createRequest<T: Decodable>(with request: URLRequest, completion: @escaping NetworkCompletion<T>) {
        // DECODE DATA
    }
}
