//
//  CodeInfo.swift
//  QRScanner
//
//  Created by Uliana Gritchina on 20.09.2025.
//

import Foundation

struct CodeInfo {
    let type: CodeType
    let stringValue: String
    let dateCreated: Date
}

enum CodeType: String {
    case qr
    case barcode
    
    var title: String {
        switch self {
        case .qr:
            "QR-code"
        case .barcode:
            "Barcode"
        }
    }
}
