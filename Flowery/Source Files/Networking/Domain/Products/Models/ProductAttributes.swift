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
    let priceData: [PriceData]
    let currencyCode: String
    let description: String
    let media: [ProductMedia]
    let ratingAverage: Double?
    let ratingCount: Int?
}

extension ProductAttributes {

    var fullPrice: Double {
        // For the purpose of test app using only first element of price date and using a force unwrap.
        // For the price conversions it would be the best to use a separate object instead of simply dividing by 100.
        // For the purpose of the testing app the easiest way was chosen.
        priceData.first!.priceInPennies / 100
    }
}

extension ProductAttributes: Decodable {

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
        priceData = try container.decode([PriceData].self, forKey: .priceData)
        currencyCode = try container.decode(String.self, forKey: .currencyCode)
        description = try container.decode(String.self, forKey: .description)
        media = try container.decode([ProductMedia].self, forKey: .media)
        ratingAverage = try container.decodeIfPresent(Double.self, forKey: .ratingAverage)
        ratingCount = try container.decodeIfPresent(Int.self, forKey: .ratingCount)
    }
}
