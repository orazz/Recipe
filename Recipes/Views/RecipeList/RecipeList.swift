//
//  RecipeList.swift
//  Recipes
//
//  Created by Oraz Atakishiyev on 10/4/24.
//  Copyright © 2024 orazz.com. All rights reserved.

import SwiftUI

struct RecipeList: View {

    @StateObject var viewModel: ReceipeViewModel

    var body: some View {
        ZStack {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .complete(let items):
                if items.isEmpty {
                    Text(MessageHelper.Common.noData)
                } else {
                    Content(items: items, viewModel: viewModel)
                }
            case .error:
                Text(MessageHelper.Common.somethingWentWrong)
            }
        }
        .task {
            await viewModel.getAllRecipes()
        }
    }

    struct Content: View {
        let items: [Recipe]
        @ObservedObject var viewModel: ReceipeViewModel
        private let columns = Array(repeating: GridItem(.flexible(), spacing: 2 * .padding, alignment: .center), count: 2)

        var body: some View {
            GeometryReader { geometry in
                let size = geometry.size.width/2 - 2 * .padding
                ScrollView {
                    LazyVGrid(columns: columns,
                              spacing: .padding) {
                        ForEach(items) { item in
                            NavigationLink {
                                VStack {
                                    Text(item.getName)
                                    Text(item.getCuisineType)
                                }
                            } label: {
                                RecipeItemView(
                                    item: item,
                                    width: size,
                                    height: size,
                                    viewModel: viewModel
                                )
                                .frame(height: geometry.size.width/2 + .labelHeight)
                            }
                        }
                    }
                    .padding(.padding)
                }
                .refreshable {
                    await viewModel.getAllRecipes()
                }
            }
        }
    }
}
