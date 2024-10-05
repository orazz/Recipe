//
//  NetworkRequests.swift
//  Recipes
//
//  Created by Oraz Atakishiyev on 10/4/24.
//  Copyright © 2024 orazz.com. All rights reserved.

import Foundation
import NetworkLayer

// MARK: - Get all recipes
struct NetworkRequestAllRecipes: INetworkRequest {
    let method = HTTPMethod.get
    let header = [String: String]()
    let parameters = Parameters.none
    let path: String = NetworkEndpoints.getAllRecipes.description
}

// MARK: - Load image
struct NetworkRequestLoadImage: INetworkRequest {
    let path: String
    let method: HTTPMethod = .get
    let header: HTTPHeader? = [:]
    let parameters: Parameters = Parameters.none

    init(_ urlStr: String) {
        self.path = NetworkEndpoints.loadImage(urlStr: urlStr).description
    }
}
