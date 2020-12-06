//
//  ProductsRequest.swift
//  Flowery
//

import Foundation

struct ProductsRequest: NetworkRequest {
    
    typealias ResponseType = ProductsResult

    var path: String {
        "/v2/availability/products/"
    }

    var query: String? {
        "locale=\(locale)&shipping_country_id=\(shippingCountryID)&first_item_in_purchase=\(isFirstItemInPurchase)"
    }

    // In the real life application this should be exposed and handled by additional object deciding which locale and country to set. For the test app purposes it's left hardcoded.
    let locale: String = "en"
    let shippingCountryID: Int = 1
    let isFirstItemInPurchase: Bool = true
}
