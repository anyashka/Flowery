//
//  ProductMedia.swift
//  Flowery
//
//  Copyright © 2020 Anna-Mariia Shkarlinska. All rights reserved.
//

import Foundation

struct ProductMedia: Equatable {
    let thumbnailURL: String
    let regularURL: String
}

extension ProductMedia: Decodable {
    private enum CodingKeys: String, CodingKey {
        case thumbnail
        case regular = "regular_url"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        thumbnailURL = try container.decode(String.self, forKey: .thumbnail)
        regularURL = try container.decode(String.self, forKey: .regular)
    }
}
