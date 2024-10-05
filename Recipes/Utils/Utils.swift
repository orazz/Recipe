//
//  Utils.swift
//  Recipes
//
//  Created by Oraz Atakishiyev on 10/5/24.
//  Copyright © 2024 orazz.com. All rights reserved.

import Foundation

enum MessageHelper {
    enum Common {
        static let somethingWentWrong = String(
            "Something went wrong."
        )
        static let noData = String(
            "No data."
        )
    }
}

func extractImagePath(from url: String) -> String? {
    guard let url = URL(string: url) else {
        return nil
    }

    let pathComponents = url.pathComponents

    // Find the index of "photos" in the path
    guard let photosIndex = pathComponents.firstIndex(of: "photos"),
          photosIndex + 2 < pathComponents.count else {
        return nil
    }

    // Extract the relevant parts of the path
    let relevantPath = pathComponents[photosIndex...photosIndex+2].joined(separator: "/")

    return relevantPath
}
