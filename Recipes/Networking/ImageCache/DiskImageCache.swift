//
//  DiskImageCacheService.swift
//  Recipes
//
//  Created by Oraz Atakishiyev on 10/6/24.
//  Copyright © 2024 orazz.com. All rights reserved.


import UIKit

// MARK: - Implementation

/// A disk-based cache conforming to `IImageProvider`
final class DiskImageCache: IImageProvider {
    private let fileManager: FileManager
    private let cacheDirectory: URL
    private let queue: DispatchQueue

    /// Initialize a new disk cache
    /// - Parameter cacheName: The name of the cache directory
    init(cacheName: String) {
        self.fileManager = FileManager.default
        let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        self.cacheDirectory = cacheDirectory.appendingPathComponent(cacheName).appendingPathComponent("photos")
        self.queue = DispatchQueue(label: "com.orazz.diskimagecache.\(cacheName)", attributes: .concurrent)

        createCacheDirectoryIfNeeded()
    }

    /// Create the cache directory if it doesn't exist
    private func createCacheDirectoryIfNeeded() {
        if !fileManager.fileExists(atPath: cacheDirectory.path) {
            do {
                try fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Error creating cache directory: \(error)")
            }
        }
    }

    /// Retrieve an image from the disk cache
    /// - Parameter key: The key to identify the image
    /// - Returns: The cached image, if available
    func image(for key: IImageCacheKey) -> UIImage? {
        let fileURL = cacheDirectory.appendingPathComponent(key.hashedValue)
        guard let data = try? Data(contentsOf: fileURL) else { return nil }
        return UIImage(data: data)
    }

    /// Store an image in the disk cache
    /// - Parameters:
    ///   - image: The image to be stored
    ///   - key: The key to identify the image
    func setImage(_ image: UIImage, for key: any IImageCacheKey) {
        queue.async(flags: .barrier) { [weak self] in
            guard let self = self else { return }
            let fileURL = self.cacheDirectory.appendingPathComponent(key.hashedValue)
            if let data = image.jpegData(compressionQuality: 0.8) {
                try? data.write(to: fileURL)
            }
        }
    }

    /// Check if an image exists in the disk cache
    /// - Parameter key: The key of the image to check for
    /// - Returns: `true` if the image exists in the cache, `false` otherwise
    func containsImage(for key: any IImageCacheKey) -> Bool {
        let fileURL = self.cacheDirectory.appendingPathComponent(key.hashedValue)
        return fileManager.fileExists(atPath: fileURL.path)
    }

    /// Remove an image from the disk cache
    /// - Parameter key: The key of the image to be removed
    func removeImage(for key: any IImageCacheKey) {
        queue.async(flags: .barrier) { [weak self] in
            guard let self = self else { return }
            let fileURL = self.cacheDirectory.appendingPathComponent(key.hashedValue)
            try? self.fileManager.removeItem(at: fileURL)
        }
    }

    /// Clear all images from the disk cache
    func clearCache() {
        queue.async(flags: .barrier) { [weak self] in
            guard let self = self else { return }
            try? self.fileManager.removeItem(at: self.cacheDirectory)
            self.createCacheDirectoryIfNeeded()
        }
    }
}
