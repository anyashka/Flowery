//
//  ProductAttributes.swift
//  Flowery
//
//  Copyright © 2020 Anna-Mariia Shkarlinska. All rights reserved.
//

import Foundation

struct ProductAttributes: Equatable {

    let name: String
    let collectionName: String
    let fullPrice: Double
    let discountedPrice: Double
    let currencyCode: String
    let description: String
    let media: [ProductMedia]
    let ratingAverage: Double?
    let ratingCount: Int?
}

extension ProductAttributes: Decodable {

    private struct PriceData: Decodable {
        let price_pennies: Double
        let price_pennies_discounted: Double

    }

    private enum CodingKeys: String, CodingKey {
        case name
        case collectionName = "collection_name"
        case currencyCode = "currency"
        case description
        case media
        case priceData = "price_data"
        case ratingAverage = "rating_average"
        case ratingCount = "rating_count"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        collectionName = try container.decode(String.self, forKey: .collectionName)
        let priceData = try container.decode([PriceData].self, forKey: .priceData)
        let firstData = priceData.first! // TODO
        // For the price conversions it would be the best to use a separate object instead of simply dividing by 100.
        // For the purpose of the testing app the easiest way was chosen.
        fullPrice = firstData.price_pennies / 100
        discountedPrice = firstData.price_pennies_discounted / 100
        currencyCode = try container.decode(String.self, forKey: .currencyCode)
        description = try container.decode(String.self, forKey: .description)
        media = try container.decode([ProductMedia].self, forKey: .media)
        ratingAverage = try container.decodeIfPresent(Double.self, forKey: .ratingAverage)
        ratingCount = try container.decodeIfPresent(Int.self, forKey: .ratingCount)
    }
}
