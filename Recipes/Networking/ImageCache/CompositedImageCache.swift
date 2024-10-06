//
//  CompositedImageCache.swift
//  Recipes
//
//  Created by Oraz Atakishiyev on 10/6/24.
//  Copyright © 2024 orazz.com. All rights reserved.

import UIKit

// A composite cache that uses both memory and disk caches
final class CompositedImageCache: IImageProvider {

    private let memoryCache: MemoryImageCache<UIImage>
    private let diskCache: DiskImageCache

    /// Initialize a new composited cache
       /// - Parameter cacheName: The name of the cache directory for the disk cache
    init(cacheName: String) {
        self.memoryCache = MemoryImageCache<UIImage>()
        self.diskCache = DiskImageCache(cacheName: cacheName)
    }

    /// Retrieve an image from the cache, checking memory first, then disk
    /// - Parameter key: The key to identify the image
    /// - Returns: The cached image, if available
    func image(for key: IImageCacheKey) -> UIImage? {
        if let memoryImage = memoryCache.image(for: key) {
            return memoryImage
        }
        if let diskImage = diskCache.image(for: key) {
            memoryCache.setImage(diskImage, for: key)
            return diskImage
        }
        return nil
    }

    /// Store an image in both memory and disk caches
    /// - Parameters:
    ///   - image: The image to be stored
    ///   - key: The key to identify the image
    func setImage(_ image: UIImage, for key: IImageCacheKey) {
        memoryCache.setImage(image, for: key)
        diskCache.setImage(image, for: key)
    }

    /// Remove an image from both memory and disk caches
    /// - Parameter key: The key of the image to be removed
    func removeImage(for key: IImageCacheKey) {
        memoryCache.removeImage(for: key)
        diskCache.removeImage(for: key)
    }

    /// Clear all images from both memory and disk caches
    func clearCache() {
        memoryCache.clearCache()
        diskCache.clearCache()
    }

    /// Check if an image exists in either memory or disk cache
    /// - Parameter key: The key of the image to check for
    /// - Returns: `true` if the image exists in either cache, `false` otherwise
    func containsImage(for key: IImageCacheKey) -> Bool {
        return memoryCache.containsImage(for: key) || diskCache.containsImage(for: key)
    }
}
