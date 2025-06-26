//
//  AppAsyncImage.swift
//  Vend
//
//  Created by Can Kurtur on 2025-06-26.
//

import SwiftUI
import Kingfisher

struct AppAsyncImage: View {
    var url: String?
    
    var body: some View {
        if let url {
            KFImage(URL(string: url))
                .placeholder {
                    ProgressView()
                }
                .cacheOriginalImage(true)
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            Image(systemName: "photo.fill")
        }
    }
}

#Preview {
    AppAsyncImage(url: "https://picsum.photos/200")
}
