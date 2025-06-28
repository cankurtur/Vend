//
//  PhotoListView.swift
//  Vend
//
//  Created by Can Kurtur on 2025-06-25.
//

import SwiftUI

// MARK: - PhotoListView

struct PhotoListView: View {
    @StateObject var viewModel = PhotoListViewModel()
    
    var body: some View {
        ZStack {
            List {
                ForEach($viewModel.items) { $item in
                    switch item {
                    case .content(let photoCellModel):
                        PhotoCellView(model: photoCellModel)
                    case .ad(let bannerAdViewModel):
                        BannerAdView(viewModel: bannerAdViewModel)
                    }
                }
            }
        }
        .task {
            await viewModel.getItems()
        }
    }
}

// MARK: - Preview

#Preview {
    PhotoListView()
}


