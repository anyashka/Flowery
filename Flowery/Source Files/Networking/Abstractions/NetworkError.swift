//
//  NetworkError.swift
//  NetworkingKit
//

import Foundation

/// A simple wrapper around Error for handling errors
///
/// - systemError: operating system threw an error. This is probably caused by no internet connection, wrong SSL certificate installed etc.
/// - describedError: request returned 4XX return code with a desription of an error.
/// - improperResponse: parsing the obtained response was impossible. Check the Codable conformances in models.
/// - notFound: received a 404 error code in response.
/// - invalidRequest: received a 40X indicating the performed request contained wrong data.
/// - requestParsingFailed: request builder failed to parse the request
/// - serverError: received a 5XX error. Probably the server is down.
/// - unauthorized: received a 401 error. User is unauthenticated.
/// - forbidden: received a 403 error. User is unauthorized to access this resource.
/// - unknown: unknown error.
/// - noData: received no data from backend where there should be some.
enum NetworkError: Error {

    case systemError(error: Error)
    case describedError(description: String)
    case improperResponse(error: Error)
    case notFound
    case invalidRequest
    case requestParsingFailed
    case serverError
    case unauthorized
    case forbidden
    case unknown
    case noData

    init?(code: Int) {
        switch code {
        case 404:
            self = .notFound
        case 403:
            self = .forbidden
        case 401:
            self = .unauthorized
        case 400...499:
            self = .invalidRequest
        case 500...599:
            self = .serverError
        default:
            return nil
        }
    }
}

extension NetworkError: Equatable {

    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.unknown, .unknown),
             (.invalidRequest, .invalidRequest),
             (.requestParsingFailed, .requestParsingFailed),
             (.notFound, .notFound),
             (.serverError, .serverError),
             (.forbidden, .forbidden),
             (.noData, .noData),
             (.unauthorized, .unauthorized):
            return true
        case let (.systemError(e1), .systemError(e2)),
             let (.improperResponse(error: e1), .improperResponse(error: e2)):
            let nse1 = e1 as NSError
            let nse2 = e2 as NSError
            return nse1 == nse2
        case let (.describedError(s1), .describedError(s2)):
            return s1 == s2
        default:
            return false
        }
    }
}
