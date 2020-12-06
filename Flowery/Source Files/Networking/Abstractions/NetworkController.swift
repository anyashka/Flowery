//
//  NetworkingController.swift
//  NetworkingKit
//
//  Copyright © 2020 Anna-Mariia Shkarlinska. All rights reserved.
//

import Foundation

protocol NetworkController: AnyObject {

    /// Initializes a new instance of NetworkClient.
    /// - Parameters:
    ///     - requestBuilder: request builder you wish to use for request creation.
    init(requestBuilder: RequestBuilder, session: NetworkSession)

    /// Performs request to the API.
    /// - Parameter request: APIRequest with all required configuration.
    func perform<Request: NetworkRequest>(request: Request, completion: @escaping (Result<Request.ResponseType, NetworkError>) -> Void)

    /// Cancels all requests that haven't completed yet.
    func cancelPendingRequests()
}
