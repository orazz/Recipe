//
//  RecipeListViewModel.swift
//  Recipes
//
//  Created by Oraz Atakishiyev on 10/4/24.
//  Copyright © 2024 orazz.com. All rights reserved.

import SwiftUI

@MainActor
final class ReceipeViewModel: ObservableObject {

    enum LoadingState: Equatable {
        case loading
        case complete([Recipe])
        case error
    }

    // MARK: - Publishers
    @Published var state: LoadingState = .loading

    // MARK: - Private properties
    private let recipeNetworkService: IRecipeNetworkService

    init(_ recipeNetworkService: IRecipeNetworkService = RecipeNetworkService()) {
        self.recipeNetworkService = recipeNetworkService
    }

    // MARK: - Methods
    func getAllRecipes() async {
        state = .loading
        do {
            let items: ServerResponse = try await recipeNetworkService.getAllRecipes()
            state = .complete(items.recipes)
        } catch {
            state = .error
        }
    }

    func loadImage(from urlStr: String) async -> UIImage? {
        do {
            guard let imagePath = extractImagePath(from: urlStr) else { return nil }
            return try await recipeNetworkService.loadImage(from: imagePath)
        } catch { }
        return nil
    }
}



