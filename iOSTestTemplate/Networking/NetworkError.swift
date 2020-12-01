//
//  NetworkError.swift
//  iOSTestTemplate
//
//  Created by Param Veghal on 23/09/2020.
//  Copyright © 2020 Param Veghal. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case invalidRequest
    case noInternetConnection
    case noHTTPURLResponse
    case statusCodeError(statusCode: Int)
    case sessionError(error: Error)
    case couldNotParseData(error: Error)
    case unknown
}
