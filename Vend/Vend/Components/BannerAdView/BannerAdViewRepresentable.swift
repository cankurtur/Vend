//
//  BannerAdViewRepresentable.swift
//  Vend
//
//  Created by Can Kurtur on 2025-06-28.
//

import SwiftUI
import GoogleMobileAds

// MARK: - BannerAdViewRepresentable

struct BannerAdViewRepresentable: UIViewRepresentable{
    let bannerView: BannerView
    
    func makeUIView(context: Context) -> some UIView {
        return bannerView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
