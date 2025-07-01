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
    @State private var isShowAlert: Bool = false
    @State private var currentAlertModel: AlertModel?
    
    var body: some View {
        List {
            ForEach(0..<viewModel.items.count, id: \.self) { index in
                switch viewModel.items[index] {
                case .content(let photoCellModel):
                    VStack {
                        Text(String(format: Localizable.position, index + 1))
                        PhotoCellView(model: photoCellModel)
                            .onAppear {
                                Task {
                                    if index == viewModel.items.count - 1 {
                                        await viewModel.getItems()
                                    }
                                }
                            }
                    }
                case .ad(let bannerAdViewModel):
                    VStack {
                        Text(String(format: Localizable.position, index + 1))
                        BannerAdView(viewModel: bannerAdViewModel)
                            .onAppear {
                                Task {
                                    if index == viewModel.items.count - 1 {
                                        await viewModel.getItems()
                                    }
                                }
                            }
                    }
                }
            }
        }
        .onReceive(viewModel.$fetchState, perform: { state in
            switch state {
            case .failure(let message):
                currentAlertModel = AlertModel(message: message)
                isShowAlert = true
            default:
                break
            }
        })
        .appAlert(isPresented: $isShowAlert, alertModel: currentAlertModel)
        .task {
            await viewModel.getItems()
        }
    }
}

// MARK: - Preview

#Preview {
    PhotoListView()
}
