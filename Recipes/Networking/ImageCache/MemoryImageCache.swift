//
//  MemoryImageCache.swift
//  Recipes
//
//  Created by Oraz Atakishiyev on 10/6/24.
//  Copyright © 2024 orazz.com. All rights reserved.

import Foundation

// MARK: - Protocol

/// Defines methods for retrieving and setting images
protocol IImageProvider {
    /// The type of image this provider works with
    associatedtype ImageType

    /// Retrieve an image from the cache
    /// - Parameter key: The key to identify the image
    /// - Returns: The cached image, if available
    func image(for key: IImageCacheKey) -> ImageType?

    /// Store an image in the cache
    /// - Parameters:
    ///   - image: The image to be stored
    ///   - key: The key to identify the image
    func setImage(_ image: ImageType, for key: IImageCacheKey)

    /// Check if an image exists in the cache
    /// - Parameter key: The key of the image to check for
    /// - Returns: `true` if the image exists in the cache, `false` otherwise
    func containsImage(for key: IImageCacheKey) -> Bool

    /// Remove an image from the cache
    /// - Parameter key: The key of the image to be removed
    func removeImage(for key: IImageCacheKey)

    /// Clear all images from the cache
    func clearCache()
}

// MARK: - Implementation

/// An in-memory cache conforming to `IImageProvider`
final class MemoryImageCache<ImageType>: IImageProvider {
    private let cache = NSCache<NSString, AnyObject>()

    /// Retrieve an image from the memory cache
    /// - Parameter key: The key to identify the image
    /// - Returns: The cached image, if available
    func image(for key: any IImageCacheKey) -> ImageType? {
        print("returning from memory")
        return cache.object(forKey: NSString(string: key.stringValue)) as? ImageType
    }

    /// Store an image in the memory cache
    /// - Parameters:
    ///   - image: The image to be stored
    ///   - key: The key to identify the image
    func setImage(_ image: ImageType, for key: any IImageCacheKey) {
        cache.setObject(image as AnyObject, forKey: NSString(string: key.stringValue))
    }

    /// Check if an image exists in the memory cache
    /// - Parameter key: The key of the image to check for
    /// - Returns: `true` if the image exists in the cache, `false` otherwise
    func containsImage(for key: any IImageCacheKey) -> Bool {
        return cache.object(forKey: NSString(string: key.stringValue)) != nil
    }

    /// Remove an image from the memory cache
    /// - Parameter key: The key of the image to be removed
    func removeImage(for key: any IImageCacheKey) {
        cache.removeObject(forKey: NSString(string: key.stringValue))
    }

    /// Clear all images from the memory cache
    func clearCache() {
        cache.removeAllObjects()
    }
}
