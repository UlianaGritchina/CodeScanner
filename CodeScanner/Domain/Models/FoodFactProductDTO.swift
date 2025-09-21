//
//  FoodFactProductDTO.swift
//  CodeScanner
//
//  Created by Uliana Gritchina on 21.09.2025.
//

import Foundation

struct FoodFactProductDTO: Decodable {
    let id: String
    let brands: String?
    let name: String?
    let ingredients: [ProductIngredient]?
    let imageURL: String?
    
    struct ProductIngredient: Decodable {
        let text: String
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case brands
        case name = "generic_name"
        case ingredients
        case imageURL = "image_url"
    }
}
