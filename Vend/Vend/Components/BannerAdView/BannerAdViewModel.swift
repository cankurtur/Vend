//
//  BannerAdViewModel.swift
//  Vend
//
//  Created by Can Kurtur on 2025-06-28.
//

import Foundation
import GoogleMobileAds

// MARK: - BannerAdViewModel

final class BannerAdViewModel: ObservableObject, Identifiable {
    let id = UUID()
    @Published var status: BannerStatus
    let banner: BannerView

    init(banner: BannerView, status: BannerStatus) {
        self.banner = banner
        self.status = status
    }
}
