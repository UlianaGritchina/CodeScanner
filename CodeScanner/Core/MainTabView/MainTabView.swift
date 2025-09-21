//
//  MainTabView.swift
//  QRScanner
//
//  Created by Uliana Gritchina on 20.09.2025.
//

import SwiftUI

struct MainTabView: View {
    
    var body: some View {
        TabView {
            ScanView()
                .tabItem {
                    Label(
                        Tab.scanner.rawValue,
                        systemImage: Tab.scanner.imageName
                    )
                }
            
            SavedCodesView()
                .tabItem {
                    Label(
                        Tab.savedCodes.rawValue,
                        systemImage: Tab.savedCodes.imageName
                    )
                }
        }
    }
}

#Preview {
    MainTabView()
}
