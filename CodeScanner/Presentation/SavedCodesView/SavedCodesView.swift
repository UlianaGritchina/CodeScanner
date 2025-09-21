//
//  SavedCodesView.swift
//  QRScanner
//
//  Created by Uliana Gritchina on 21.09.2025.
//

import SwiftUI

struct SavedCodesView: View {
    
    // MARK: StateObject
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.background.ignoresSafeArea()
                ScrollView {
                    codesList
                }
            }
            .navigationTitle("Saved")
            .onAppear { viewModel.fetchSavedCodes() }
            .sheet(isPresented: $viewModel.isOpenCodeDetailsView, onDismiss: {
                viewModel.fetchSavedCodes()
            }) {
                if let code = viewModel.selectedCode {
                    CodeDetailsView(
                        code: code,
                        foodFactsRepository: FoodFactsRepository()
                    )
                }
            }
        }
    }
}

#Preview {
    SavedCodesView()
}

extension SavedCodesView {
    @ViewBuilder private var codesList: some View {
        if let codes = viewModel.savedCodes, !codes.isEmpty {
            VStack(spacing: 10) {
                ForEach(codes, id: \.stringValue) { code in
                    Button(action: { viewModel.selectCode(code) }) {
                        CodeInfoRow(code: code)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
        } else {
            Text("No saved codes yet.")
                .font(.headline)
        }
    }
}
