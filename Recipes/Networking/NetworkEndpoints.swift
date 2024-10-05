//
//  NetworkEndpoints.swift
//  Recipes
//
//  Created by Oraz Atakishiyev on 10/4/24.
//  Copyright © 2024 orazz.com. All rights reserved.

import Foundation

enum NetworkEndpoints {
    static let baseURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net")!

    case getAllRecipes
    case loadImage(urlStr: String)
}

extension NetworkEndpoints: CustomStringConvertible {
    var description: String {
        switch self {
        case .getAllRecipes:
            return "recipes.json"
        case .loadImage(let urlStr):
            return urlStr
        }
    }
}
