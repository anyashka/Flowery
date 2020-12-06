//
//  ProductsResult.swift
//  Flowery
//

import Foundation

struct ProductsResult {
    let products: [Product]
}

extension ProductsResult: Decodable {

    private enum CodingKeys: String, CodingKey {
        case products = "data"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        products = try container.decode([Product].self, forKey: .products)
    }
}
