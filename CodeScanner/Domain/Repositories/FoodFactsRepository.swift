//
//  FoodFactsRepository.swift
//  QRScanner
//
//  Created by Uliana Gritchina on 21.09.2025.
//

import Foundation

protocol IFoodFactsRepository {
    func fetchProductInfo(for barcode: String) async throws -> FoodFactProduct
}

final class FoodFactsRepository: IFoodFactsRepository {
    static let shared = FoodFactsRepository()
    
    private init() { }
    
    func fetchProductInfo(for barcode: String) async throws -> FoodFactProduct {
        guard let url = URL(string: "https://world.openfoodfacts.org/api/v0/product/\(barcode).json") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let foodFactResponse = try JSONDecoder().decode(FoodFactResponse?.self, from: data)
       
        if let product = FoodFactProductMapper.shared.map(dto: foodFactResponse?.product) {
            return product
        } else {
            throw URLError(.badServerResponse)
        }
    }
}

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
