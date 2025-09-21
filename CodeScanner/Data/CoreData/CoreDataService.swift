//
//  CoreDataService.swift
//  QRScanner
//
//  Created by Uliana Gritchina on 21.09.2025.
//

import CoreData

final class CoreDataService {
    
    static let shared = CoreDataService()
    
    private let container: NSPersistentContainer
    var savedCodesEntities: [CodeEntity] = []
    
    private init() {
        container = NSPersistentContainer(name: "QRScanner")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading core data \(error)")
            } else {
                print("Successfully loading Core Data")
            }
        }
    }
    
    // MARK: Private methods
    
    private func saveData() {
        do {
            try container.viewContext.save()
        } catch {
            print("Error saving \(error)")
        }
    }
    
    func fetchSavedCodes() async throws -> [CodeInfo]? {
        let request = NSFetchRequest<CodeEntity>(entityName: "CodeEntity")
        do {
            savedCodesEntities = try container.viewContext.fetch(request)
            let savedCodes = savedCodesEntities.compactMap({
                CodeInfoMapper.shared.map(entity: $0 )
            })
            return savedCodes
        } catch {
            throw error
        }
    }
    
    func saveCode(_ code: CodeInfo) {
        let newCode = CodeEntity(context: container.viewContext)
        newCode.type = code.type.rawValue
        newCode.stringValue = code.stringValue
        newCode.dateCreated = code.dateCreated
        saveData()
    }
    
    func deleteCode(_ code: CodeInfo) {
        if let codeForDelete = savedCodesEntities.first(where: {
            $0.stringValue == code.stringValue
        }) {
            container.viewContext.delete(codeForDelete)
            saveData()
        }
    }
}
