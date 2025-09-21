//
//  CodeDetailsViewModel.swift
//  QRScanner
//
//  Created by Uliana Gritchina on 20.09.2025.
//

import Foundation

extension CodeDetailsView {
    @MainActor final class ViewModel: ObservableObject {
        
        // MARK: Constants
        
        private let foodFactsRepository = FoodFactsRepository.shared
        private let coreDataService = CoreDataService.shared
        
        let codeInfo: CodeInfo
        let qrURL: URL?
        
        // MARK: Published
        
        @Published private(set) var product: FoodFactProduct?
        @Published private(set) var imageData: Data?
        @Published private(set) var savedCodes: [CodeInfo]?
        @Published private(set) var isCodeSaved = false
        @Published private(set) var isFailedToLoadProduct = false
        
        @Published var isOpenActivityView = false
        
        init(codeDetails: CodeInfo) {
            self.codeInfo = codeDetails
            qrURL = URL(string: codeDetails.stringValue)
            fetchProductInfo()
            fetchSavedCodes()
        }
        
        // MARK: Private methods
        
        private func fetchProductInfo() {
            guard codeInfo.type == .barcode else { return }
            Task {
                do {
                    product = try await foodFactsRepository.fetchProductInfo(for: codeInfo.stringValue)
                    guard let productImageURL = product?.imageURL else { return }
                    fetchProductImage(url: productImageURL)
                    isFailedToLoadProduct = false
                } catch {
                    isFailedToLoadProduct = true
                }
            }
        }
        
        private func fetchProductImage(url: URL)  {
            Task {
                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    DispatchQueue.main.async {
                        self.imageData = data
                    }
                }
            }
        }
        
        private func fetchSavedCodes() {
            Task {
                do {
                    savedCodes = try await coreDataService.fetchSavedCodes()
                    isCodeSaved = savedCodes?.contains(where: { $0.stringValue == codeInfo.stringValue }) ?? false
                }
            }
        }
        
        // MARK: Public methods
        
        func saveButtonTapped() {
            if isCodeSaved {
                coreDataService.deleteCode(codeInfo)
            } else {
                coreDataService.saveCode(codeInfo)
            }
            isCodeSaved.toggle()
        }
        
        func openActivityView() {
            isOpenActivityView = true
        }
    }
}
