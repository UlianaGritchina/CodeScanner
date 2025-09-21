//
//  CodeInoRow.swift
//  QRScanner
//
//  Created by Uliana Gritchina on 20.09.2025.
//

import SwiftUI

struct CodeInfoRow: View {
    let code: CodeInfo
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(code.stringValue)
                .font(.headline)
            
            HStack(alignment: .bottom) {
                Text(code.type.title)
                    .font(.subheadline)
                Spacer()
                Text(code.dateCreated.toString())
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background {
            Color.cardBackground
                .cornerRadius(8)
                .shadow(color: Color.shadow, radius: 5)
        }
    }
}

#Preview {
    CodeInfoRow(
        code: CodeInfo(
            type: CodeType.barcode,
            stringValue: "q4323",
            dateCreated: Date()
        )
    )
}
