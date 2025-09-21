//
//  CodeInfoMapper.swift
//  CodeScanner
//
//  Created by Uliana Gritchina on 21.09.2025.
//

import Foundation

final class CodeInfoMapper {
    static let shared = CodeInfoMapper()
    
    private init() { }
    
    func map(entity: CodeEntity) -> CodeInfo? {
        guard
            let type = entity.type,
            let stringValue = entity.stringValue,
            let dateCreated = entity.dateCreated
        else { return nil }
        
        return CodeInfo(
            type: type ==  "qr" ? CodeType.qr : CodeType.barcode,
            stringValue: stringValue,
            dateCreated: dateCreated
        )
    }
}
