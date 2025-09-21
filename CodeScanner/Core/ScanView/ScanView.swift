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
        ScannerView(scanResult: $viewModel.codeDetails)
            .ignoresSafeArea()
            .sheet(isPresented: $viewModel.isOpenCodeDetailsView, onDismiss: {
                viewModel.addCodeDetailsListener()
            }) {
                if let codeDetails = viewModel.codeDetails {
                    CodeDetailsView(codeDetails: codeDetails)
                }
            }
    }
}

#Preview {
    ScanView()
}
