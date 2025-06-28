//
//  AdManager.swift
//  Vend
//
//  Created by Can Kurtur on 2025-06-28.
//

import SwiftUI
import GoogleMobileAds

// MARK: - AdManager

final class AdManager: NSObject {
    static let shared = AdManager()
    @Published var bannerItems: [BannerAdViewModel] = []
    
    private override init() { }
    
    func preloadBannerAds(count: Int) {
        for _ in 0..<count {
            let viewWidth = UIScreen.main.bounds.width
            let adSize = portraitAnchoredAdaptiveBanner(width: viewWidth)

            let banner = BannerView(adSize: adSize)
            banner.adUnitID = Config.shared.googleAdAdaptiveBannerID
            banner.delegate = self
            banner.load(Request())
            bannerItems.append(BannerAdViewModel(banner: banner, status: .loading))
        }
    }
}

// MARK: - BannerViewDelegate

extension AdManager: BannerViewDelegate {
    func bannerViewDidReceiveAd(_ bannerView: BannerView) {
        if let index = self.bannerItems.firstIndex(where: { $0.banner === bannerView }),
           bannerItems[index].status != .success {
            self.bannerItems[index].status = .success
        }
    }
    
    func bannerView(_ bannerView: BannerView, didFailToReceiveAdWithError error: any Error) {
        if let index = self.bannerItems.firstIndex(where: {$0.banner === bannerView}) {
            self.bannerItems[index].status = .failure
        }
    }
}
