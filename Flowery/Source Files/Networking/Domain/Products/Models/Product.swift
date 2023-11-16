//
//  Product.swift
//  Flowery
//

import Foundation

enum Watering: String, Codable {
    case frequent = "Frequent"
    case average = "Average"
    case minimum = "Minimum"
    case none = "None"
}

struct Product: Equatable {
    let id: String
    let commonName: String
    let scientificName: String
    let image: ProductMedia?
    let watering: Watering
}

extension Product: Decodable {

    private enum CodingKeys: String, CodingKey {
        case id
        case name = "common_name"
        case scientificName = "scientific_name"
        case image = "default_image"
        case watering
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try String(container.decode(Int.self, forKey: .id))
        commonName = try container.decode(String.self, forKey: .name)
        scientificName = try container.decode([String].self, forKey: .scientificName)[0]
        image = try? container.decode(ProductMedia.self, forKey: .image)
        watering = try container.decode(Watering.self, forKey: .watering)
    }
}

