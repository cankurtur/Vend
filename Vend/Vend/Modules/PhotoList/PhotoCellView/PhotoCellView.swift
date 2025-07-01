//
//  PhotoCellView.swift
//  Vend
//
//  Created by Can Kurtur on 2025-06-26.
//

import SwiftUI

// MARK: - PhotoCellView

struct PhotoCellView: View {
    var model: PhotoCellModel
    
    var body: some View {
        VStack {
            AppAsyncImage(url: model.thumbnailURL)
            Text(model.title ?? Localizable.noTitle)
                .frame(height: 50)
                .font(.headline)
                .multilineTextAlignment(.center)
                .bold()
        }
        .frame(height: 300)
        .padding()
    }
}

// MARK: - Preview

#Preview {
    PhotoCellView(model: PhotoCellModel(
        title: "Test",
        photoURL: "https://picsum.photos/200",
        thumbnailURL: "https://picsum.photos/200"
    ))
}
