//
//  ScanViewModel.swift
//  QRScanner
//
//  Created by Uliana Gritchina on 20.09.2025.
//

import Combine
import Foundation

extension ScanView {
    @MainActor final class ViewModel: ObservableObject {
        
        // MARK: Published
        
        @Published var codeDetails: CodeInfo?
        @Published var isOpenCodeDetailsView = false
        
        // MARK: Private variables
        
        private var cancellables = Set<AnyCancellable>()
        
        init() {
            addCodeDetailsListener()
        }
        
        // MARK: Private methods
        
        private func openCodeDetailsView() {
            isOpenCodeDetailsView = true
        }
        
        // MARK: Private methods
        
        func addCodeDetailsListener() {
            codeDetails = nil
            $codeDetails.sink { [weak self] details in
                guard let self else { return }
                DispatchQueue.main.async {
                    if let details {
                        self.codeDetails = details
                        self.openCodeDetailsView()
                        self.cancellables = []
                    }
                }
            }
            .store(in: &cancellables)
        }
    }
}
