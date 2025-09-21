//
//  FoodFactResponse.swift
//  QRScanner
//
//  Created by Uliana Gritchina on 20.09.2025.
//

import Foundation

struct FoodFactResponse: Decodable {
    let code: String
    let product: FoodFactProductDTO?
}
