//
//  QRScannerApp.swift
//  QRScanner
//
//  Created by Uliana Gritchina on 20.09.2025.
//

import SwiftUI

@main
struct QRScannerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
