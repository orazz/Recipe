//
//  MockRecipeNetworkService.swift
//  Recipes
//
//  Created by Oraz Atakishiyev on 10/5/24.
//  Copyright © 2024 orazz.com. All rights reserved.

import XCTest
@testable import Recipes

class MockRecipeNetworkService: IRecipeNetworkService {
    var mockGetAllRecipesResult: ServerResponse?
    var mockGetAllRecipesError: Error?
    var mockLoadImageResult: UIImage?
    var mockLoadImageError: Error?

    func getAllRecipes() async throws -> ServerResponse {
        if let error = mockGetAllRecipesError {
            throw error
        }
        guard let result = mockGetAllRecipesResult else {
            throw TestError.noData
        }
        return result
    }

    func loadImage(from urlString: String) async throws -> UIImage {
        if let error = mockLoadImageError {
            throw error
        }
        guard let image = mockLoadImageResult else {
            throw TestError.noData
        }
        return image
    }
}
