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
                .frame(width: 300, height: 300)
            Text(model.title ?? "No Title")
                .font(.headline)
                .multilineTextAlignment(.center)
                .bold()
        }
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
