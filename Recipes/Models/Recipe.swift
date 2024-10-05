//
//  Recipe.swift
//  Recipes
//
//  Created by Oraz Atakishiyev on 10/4/24.
//  Copyright © 2024 orazz.com. All rights reserved.

import Tagged
import Foundation

struct ServerResponse: Codable {
    let recipes: [Recipe]
}

struct Recipe: Equatable, Identifiable, Codable {
    let cuisine, name: String?
    let photoURLLarge, photoURLSmall: String
    let sourceURL: String?
    let id: Tagged<Self, UUID>
    let youtubeURL: String?

    enum CodingKeys: String, CodingKey {
        case cuisine, name
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case sourceURL = "source_url"
        case id = "uuid"
        case youtubeURL = "youtube_url"
    }

    var getName: String {
        return name ?? "Unknown"
    }

    var getCuisineType: String {
        return cuisine ?? "Unknown"
    }
}

extension Recipe {
    static let mock = [
        Recipe(
            cuisine: "Italian",
            name: "Spaghetti Carbonara",
            photoURLLarge: "https://example.com/photos/large/spaghetti-carbonara.jpg",
            photoURLSmall: "https://example.com/photos/small/spaghetti-carbonara.jpg",
            sourceURL: "https://example.com/recipes/spaghetti-carbonara",
            id: Recipe.ID(UUID()),
            youtubeURL: "https://youtube.com/watch?v=carbonara"
        ),
        Recipe(
            cuisine: "Mexican",
            name: "Tacos Al Pastor",
            photoURLLarge: "https://example.com/photos/large/tacos-al-pastor.jpg",
            photoURLSmall: "https://example.com/photos/small/tacos-al-pastor.jpg",
            sourceURL: "https://example.com/recipes/tacos-al-pastor",
            id: Recipe.ID(UUID()),
            youtubeURL: "https://youtube.com/watch?v=tacos-al-pastor"
        ),
    ]
}
