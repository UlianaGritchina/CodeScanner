//
//  Date+Extension.swift
//  QRScanner
//
//  Created by Uliana Gritchina on 20.09.2025.
//

import Foundation

extension Date {
    func toString(format: String = "d MMM yyy, HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
