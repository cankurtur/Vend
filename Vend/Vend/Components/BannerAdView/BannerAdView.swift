//
//  BannerAdView.swift
//  Vend
//
//  Created by Can Kurtur on 2025-06-28.
//

import SwiftUI
import GoogleMobileAds

// MARK: - BannerAdView

struct BannerAdView: View {
    @ObservedObject var viewModel: BannerAdViewModel

    var body: some View {
        ZStack {
            switch viewModel.status {
            case .loading:
                HStack(spacing: 8) {
                    Text(Localizable.advertising)
                    ProgressView()
                }
            case .success:
                BannerAdViewRepresentable(bannerView: viewModel.banner)
            case .failure:
                Text(Localizable.advertisingFailed)
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: 300)
    }
}
