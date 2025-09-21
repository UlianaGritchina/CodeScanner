//
//  ScanView.swift
//  QRScanner
//
//  Created by Uliana Gritchina on 20.09.2025.
//

import SwiftUI

struct ScanView: View {
    
    // MARK: StateObject
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ScannerView(scanResult: $viewModel.codeInfo)
            .ignoresSafeArea()
            .sheet(isPresented: $viewModel.isOpenCodeDetailsView, onDismiss: {
                viewModel.addCodeDetailsListener()
            }) {
                if let code = viewModel.codeInfo {
                    CodeDetailsView(
                        code: code,
                        foodFactsRepository: FoodFactsRepository()
                    )
                }
            }
    }
}

#Preview {
    ScanView()
}
