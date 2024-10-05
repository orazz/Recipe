//
//  RecipesTests.swift
//  Recipes
//
//  Created by Oraz Atakishiyev on 10/4/24.
//  Copyright © 2024 orazz.com. All rights reserved.

import XCTest
@testable import Recipes

@MainActor
class ReceipeViewModelTests: XCTestCase {
    var viewModel: ReceipeViewModel!
    var mockNetworkService: MockRecipeNetworkService!

    override func setUp() {
        super.setUp()
        mockNetworkService = MockRecipeNetworkService()
        viewModel = ReceipeViewModel(mockNetworkService)
    }

    override func tearDown() {
        viewModel = nil
        mockNetworkService = nil
        super.tearDown()
    }

    func testGetAllRecipesSuccess() async {
        // Given
        let mockRecipes = Recipe.mock
        mockNetworkService.mockGetAllRecipesResult = ServerResponse(recipes: mockRecipes)

        // When
        await viewModel.getAllRecipes()

        // Then
        XCTAssertEqual(viewModel.state, .complete(mockRecipes))
    }

    func testGetAllRecipesNetworkError() async {
        // Given
        mockNetworkService.mockGetAllRecipesError = TestError.networkError

        // When
        await viewModel.getAllRecipes()

        // Then
        XCTAssertEqual(viewModel.state, .error)
    }

    func testGetAllRecipesInvalidStatusCode() async {
        // Given
        mockNetworkService.mockGetAllRecipesError = TestError.invalidStatusCode

        // When
        await viewModel.getAllRecipes()

        // Then
        XCTAssertEqual(viewModel.state, .error)
    }

    func testGetAllRecipesNoData() async {
        // Given
        mockNetworkService.mockGetAllRecipesError = TestError.noData

        // When
        await viewModel.getAllRecipes()

        // Then
        XCTAssertEqual(viewModel.state, .error)
    }

    func testLoadImageNetworkError() async {
        // Given
        mockNetworkService.mockLoadImageError = TestError.networkError

        // When
        let result = await viewModel.loadImage(from: "https://example.com/image.jpg")

        // Then
        XCTAssertNil(result)
    }

    func testLoadImageInvalidResponse() async {
        // Given
        mockNetworkService.mockLoadImageError = TestError.invalidResponse

        // When
        let result = await viewModel.loadImage(from: "https://example.com/image.jpg")

        // Then
        XCTAssertNil(result)
    }
}
