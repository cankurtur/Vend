//
//  VendApp.swift
//  Vend
//
//  Created by Can Kurtur on 2025-06-25.
//

import SwiftUI
import GoogleMobileAds

@main
struct VendApp: App {
    init() {
        setupGoogleMobileAds()
    }
    
    var body: some Scene {
        WindowGroup {
            PhotoListView()
        }
    }
    
    private func setupGoogleMobileAds() {
        MobileAds.shared.start()
    }
}
