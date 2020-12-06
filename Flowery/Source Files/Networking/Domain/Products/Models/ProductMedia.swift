//
//  ProductMedia.swift
//  Flowery
//
//  Copyright © 2020 Anna-Mariia Shkarlinska. All rights reserved.
//

import Foundation

struct ProductMedia: Equatable {
    let url: String

    // for the purpose of testing app it was assumed that all media types are images.
}

extension ProductMedia: Decodable {}
