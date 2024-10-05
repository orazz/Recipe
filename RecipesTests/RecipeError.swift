//
//  RecipeError.swift
//  Recipes
//
//  Created by Oraz Atakishiyev on 10/5/24.
//  Copyright © 2024 orazz.com. All rights reserved.

enum TestError: Error {
    case networkError
    case invalidResponse
    case invalidStatusCode
    case noData
    case decodingError
}
