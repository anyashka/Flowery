//
//  DefaultNetworkController.swift
//  NetworkingKit
//

import UIKit

/// A default implementation of network controller.
final class DefaultNetworkController: NetworkController {

    /// Request builder used to create requests configuration.
    private let requestBuilder: RequestBuilder

    private let session: NetworkSession

    /// - SeeAlso: `NetworkController.init`
    init(requestBuilder: RequestBuilder, session: NetworkSession) {
        self.requestBuilder = requestBuilder
        self.session = session
    }

    /// - SeeAlso: `NetworkController.perform`
    func perform<Request: NetworkRequest>(request: Request, completion: @escaping (Result<Request.ResponseType, NetworkError>) -> Void) {
        let urlRequest = requestBuilder.prepare(request)
        session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            if let error = error as NSError? {
                    DispatchQueue.main.async {
                        let requestError = NetworkError(code: error.code) ?? NetworkError.describedError(description: error.localizedDescription)
                        completion(.failure(requestError))
                    }
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse, let data = data else {
                    DispatchQueue.main.async {
                        let error = NetworkError.noData
                        completion(.failure(error))
                    }
                    return
                }
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any], let error = json["error"] as? String {
                    DispatchQueue.main.async {
                        let error = NetworkError.describedError(description: error)
                        completion(.failure(error))
                    }
                    return
                }
                if let responseError = NetworkError(code: httpResponse.statusCode) {
                    DispatchQueue.main.async {
                        completion(.failure(responseError))
                    }
                    return
                }
                do {
                    guard Request.ResponseType.self != EmptyResponse.self else {
                        DispatchQueue.main.async {
                            completion(.success(EmptyResponse() as! Request.ResponseType))
                        }
                        return
                    }
                    let responseData = try JSONDecoder().decode(Request.ResponseType.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(responseData))
                    }
                } catch {
                    DispatchQueue.main.async {
                        let error = NetworkError.requestParsingFailed
                        completion(.failure(error))
                    }
                }
            }).resume()
    }

    /// - SeeAlso: `NetworkController.cancelPendingRequests`
    func cancelPendingRequests() {
        session.getAllTasks {
            $0.forEach { task in
                task.cancel()
            }
        }
    }
}
