//
//  RecipeItemView.swift
//  Recipes
//
//  Created by Oraz Atakishiyev on 10/4/24.
//  Copyright © 2024 orazz.com. All rights reserved.

import SwiftUI

struct RecipeItemView: View {
    var item: Recipe
    var width: CGFloat = .zero
    var height: CGFloat = .zero
    @ObservedObject private var viewModel: ReceipeViewModel
    @State private var image: Image?

    init(item: Recipe, width: CGFloat, height: CGFloat, viewModel: ReceipeViewModel) {
        self.item = item
        self.width = width
        self.height = height
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(
            alignment: .leading,
            spacing: .defaultSpacing
        ) {
            AsyncImageView(url: item.photoURLSmall, viewModel: viewModel)
                .frame(width: width, height: height)
                .clipped()
                .cornerRadius(10)
            Text(item.getName)
                .font(.subheadline)
                .foregroundColor(Color(UIColor.label))
                .multilineTextAlignment(.leading)
                .lineLimit(2)
            Text(item.getCuisineType)
                .font(.footnote)
                .foregroundColor(Color(UIColor.lightGray))
        }
    }
}

#Preview {
    RecipeItemView(
        item: Recipe.mock.first!,
        width: 100,
        height: 100,
        viewModel: ReceipeViewModel()
    )
}
