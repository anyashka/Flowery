//
//  Product.swift
//  NetworkingKit
//

import Foundation

struct Product: Equatable {
    let id: String
    let attributes: ProductAttributes
}

extension Product: Decodable {}
