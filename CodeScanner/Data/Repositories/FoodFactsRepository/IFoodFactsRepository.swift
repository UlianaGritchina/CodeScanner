//
//  IFoodFactsRepository.swift
//  CodeScanner
//
//  Created by Uliana Gritchina on 21.09.2025.
//

import Foundation

protocol IFoodFactsRepository {
    func fetchProductInfo(for barcode: String) async throws -> FoodFactProduct
}
