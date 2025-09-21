//
//  CodeDetailsView.swift
//  QRScanner
//
//  Created by Uliana Gritchina on 20.09.2025.
//

import SwiftUI

struct CodeDetailsView: View {
    
    // MARK: Environment
    
    @Environment(\.dismiss) private var dismiss
    
    // MARK: StateObject
    
    @StateObject private var viewModel: ViewModel
    
    init(codeDetails: CodeInfo) {
        let vm = ViewModel(codeDetails: codeDetails)
        _viewModel = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    CodeInfoRow(code: viewModel.codeInfo)
                    
                    if viewModel.codeInfo.type == .barcode {
                        foodFactsView
                    } else {
                        qrLink
                    }
                }
                .padding()
                .padding(.bottom, 50)
            }
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                dismissButton
                shareButton
            }
            .background(Color.background)
            .overlay(alignment: .bottom) { saveButton }
            .sheet(isPresented: $viewModel.isOpenActivityView) {
                ActivityView(activityItems: [viewModel.codeInfo.stringValue])
            }
        }
    }
}

#Preview {
    CodeDetailsView(
        codeDetails: CodeInfo(
            type: CodeType.qr,
            stringValue: "https://github.com/UlianaGritchina/EasterEggs",
            dateCreated: Date()
        )
    )
}

extension CodeDetailsView {
    private var dismissButton: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button("Close", action: { dismiss()} )
        }
    }
    
    private var shareButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button("", systemImage: "square.and.arrow.up") {
                viewModel.openActivityView()
            }
        }
    }
    
    
    private var saveButton: some View {
        Button(action: {
            viewModel.saveButtonTapped()
        }) {
            Text(viewModel.isCodeSaved ? "Delete" : "Save")
                .font(.headline)
                .foregroundStyle(.white)
                .frame(height: 45)
                .frame(maxWidth: .infinity)
                .background(viewModel.isCodeSaved ? Color.red : Color.accentColor)
                .cornerRadius(8)
        }
        .padding()
    }
    
    @ViewBuilder private var foodFactsView: some View {
        if let product = viewModel.product {
            VStack(alignment: .leading, spacing: 8) {
                Text("Food Facts")
                    .font(.headline)
                
                Text("id: \(product.id)")
                
                if let imageData = viewModel.imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 500, maxHeight: 200, alignment: .leading)
                        .cornerRadius(10)
                }
                
                if let name = product.name, !name.isEmpty {
                    FoodFactRowView(title: "Name:", info: name)
                }
                
                if let brands = product.brands {
                    FoodFactRowView(title: "Brand:", info: brands)
                }
                
                if let ingredients = product.ingredients {
                    FoodFactRowView(title: "Ingredients:", info: ingredients)
                }
            }
        } else {
            if !viewModel.isFailedToLoadProduct {
                ProgressView()
            }
        }
    }
    
    @ViewBuilder private var qrLink: some View {
        if let url = viewModel.qrURL {
            Link(destination: url) {
                Label("Open link", systemImage: "link")
            }
        }
    }
    
    struct FoodFactRowView: View {
        let title: String
        let info: String
        var body: some View {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                
                Text(info)
            }
        }
    }
}
