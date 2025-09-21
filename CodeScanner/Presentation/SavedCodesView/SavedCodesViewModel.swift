//
//  SavedCodesViewModel.swift
//  QRScanner
//
//  Created by Uliana Gritchina on 21.09.2025.
//

import Foundation

extension SavedCodesView {
    @MainActor final class ViewModel: ObservableObject {
        
        // MARK: Constants
        
        private let coreDataService = CoreDataService.shared
        
        // MARK: Published
        
        @Published private(set) var savedCodes: [CodeInfo]?
        @Published private(set) var selectedCode: CodeInfo?
        
        @Published var isOpenCodeDetailsView = false
        
        init() {
            fetchSavedCodes()
        }
        
        // MARK: Public methods
        
        func selectCode(_ code: CodeInfo) {
            selectedCode = code
            isOpenCodeDetailsView = true
        }
        
        func fetchSavedCodes() {
            Task {
                do {
                    savedCodes = try await coreDataService.fetchSavedCodes()
                }
            }
        }
    }
}
