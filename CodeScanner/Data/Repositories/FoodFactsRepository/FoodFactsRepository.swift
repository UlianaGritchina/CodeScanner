//
//  FoodFactsRepository.swift
//  QRScanner
//
//  Created by Uliana Gritchina on 21.09.2025.
//

import Foundation

final class FoodFactsRepository: IFoodFactsRepository {
    
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
