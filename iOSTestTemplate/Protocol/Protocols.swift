//
//  JSONDataTaskDownloaderType.swift
//  iOSTestTemplate
//
//  Created by Param Veghal on 23/09/2020.
//  Copyright © 2020 Param Veghal. All rights reserved.
//

import Foundation

protocol JSONDataTaskDownloaderType {
    func jsonTask(with request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) -> URLSessionDataTask
}

protocol NetworkClientType {
    func createRequest<T: Decodable>(with request: URLRequest, completion: @escaping NetworkCompletion<T>)
}

protocol URLSessionType {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionType {}
