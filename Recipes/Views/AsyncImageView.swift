//
//  AsyncImageView.swift
//  Recipes
//
//  Created by Oraz Atakishiyev on 10/5/24.
//  Copyright © 2024 orazz.com. All rights reserved.

import SwiftUI

struct AsyncImageView: View {
    let url: String
    @ObservedObject var viewModel: ReceipeViewModel
    @State private var image: UIImage?
    @State private var isLoading = false

    var body: some View {
        Group {
            if isLoading {
                ProgressView()
            } else if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                Image(.placeholder)
                    .resizable()
                    .scaledToFit()
            }
        }
        .onAppear {
            Task {
                await loadImage()
            }
        }
    }

    private func loadImage() async {
        isLoading = true
        defer { isLoading = false }

        if let gotImage = await viewModel.loadImage(from: url) {
            await MainActor.run {
                self.image = gotImage
            }
        } else {
            await MainActor.run {
                self.image = nil
            }
        }

    }
}
