//
//  RecipeService.swift
//  Recipes
//
//  Created by Oraz Atakishiyev on 10/4/24.
//  Copyright © 2024 orazz.com. All rights reserved.

import Foundation
import NetworkLayer
import UIKit

// MARK: - Protocols

protocol IImageCache {
    func getImage(for key: String) -> UIImage?
    func setImage(_ image: UIImage, for key: String)
}

protocol IRecipeNetworkService {
    func getAllRecipes() async throws -> ServerResponse
    func loadImage(from urlString: String) async throws -> UIImage
}

// MARK: - ImageCache

class ImageCache: IImageCache {
    private let cache = NSCache<NSString, UIImage>()

    func getImage(for key: String) -> UIImage? {
        cache.object(forKey: NSString(string: key))
    }

    func setImage(_ image: UIImage, for key: String) {
        cache.setObject(image, forKey: NSString(string: key))
    }
}

// MARK: - RecipeNetworkService

struct RecipeNetworkService: IRecipeNetworkService {
    
    // MARK: - Proivate properties
    private let recipeNetworkService = NetworkService(session: URLSession.shared, baseURL: NetworkEndpoints.baseURL)

    private let imageCache: CompositedImageCache

    init(imageCache: CompositedImageCache = CompositedImageCache(cacheName: "RecipeImageCache")) {
        self.imageCache = imageCache
    }

    // MARK: - Public methods
    func getAllRecipes() async throws -> ServerResponse {
        return try await recipeNetworkService.perform(NetworkRequestAllRecipes())
    }

    func loadImage(from urlString: String) async throws -> UIImage {

        // Create a cache key
        let key = StringImageCacheKey(stringValue: urlString)
        let requestLoadImage = NetworkRequestLoadImage(key.stringValue)

        if let cachedImage = imageCache.image(for: key) {
            return cachedImage
        }

        let imageData: Data = try await recipeNetworkService.perform(requestLoadImage)
        guard let image = UIImage(data: imageData) else {
            throw HTTPNetworkServiceError.invalidResponse(nil)
        }

        imageCache.setImage(image, for: key)

        return image
    }
}
