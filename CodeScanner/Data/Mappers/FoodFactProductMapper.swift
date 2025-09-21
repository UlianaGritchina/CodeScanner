//
//  FoodFactProductMapper.swift
//  CodeScanner
//
//  Created by Uliana Gritchina on 21.09.2025.
//

import Foundation

final class FoodFactProductMapper {
    static let shared = FoodFactProductMapper()
    
    private init() { }
    
    func map(dto: FoodFactProductDTO?) -> FoodFactProduct? {
        guard let dto else { return nil }
        
        return FoodFactProduct(
            id: dto.id,
            brands: dto.brands,
            name: dto.name,
            ingredients: dto.ingredients?.compactMap({ $0.text }).joined(separator: ", "),
            imageURL: URL(string: dto.imageURL ?? "")
        )
    }
}
