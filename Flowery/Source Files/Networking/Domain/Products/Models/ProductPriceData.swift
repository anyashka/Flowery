//
//  ProductPriceData.swift
//  Flowery
//
//  Copyright © 2020 Anna-Mariia Shkarlinska. All rights reserved.
//

import Foundation

struct PriceData: Equatable {
    let priceInPennies: Double
    let priceInPenniesDiscounted: Double
}

extension PriceData: Decodable {
    private enum CodingKeys: String, CodingKey {
        case price = "price_pennies"
        case discountedPrice = "price_pennies_discounted"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        priceInPennies = try container.decode(Double.self, forKey: .price)
        priceInPenniesDiscounted = try container.decode(Double.self, forKey: .discountedPrice)
    }
}
