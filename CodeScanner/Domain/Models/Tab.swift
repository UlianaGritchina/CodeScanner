//
//  Tab.swift
//  QRScanner
//
//  Created by Uliana Gritchina on 20.09.2025.
//

import Foundation

enum Tab: String {
    case scanner = "Scanner"
    case savedCodes = "Saved"
    
    var imageName: String {
        switch self {
        case .scanner:
            "qrcode.viewfinder"
        case .savedCodes:
            "list.bullet"
        }
    }
}
