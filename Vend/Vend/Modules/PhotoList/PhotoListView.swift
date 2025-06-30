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
        List {
            ForEach(0..<viewModel.items.count, id: \.self) { index in
                switch viewModel.items[index] {
                case .content(let photoCellModel):
                    VStack {
                        Text("Position: \(index+1)")
                        PhotoCellView(model: photoCellModel)
                            .task {
                                await viewModel.paginateIfNeeded(for: index)
                            }
                    }
                case .ad(let bannerAdViewModel):
                    VStack {
                        Text("Position: \(index+1)")
                        BannerAdView(viewModel: bannerAdViewModel)
                            .task {
                                await viewModel.paginateIfNeeded(for: index)
                            }
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
