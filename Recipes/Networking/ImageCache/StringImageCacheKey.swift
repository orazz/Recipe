//
//  StringImageCacheKey.swift
//  Recipes
//
//  Created by Oraz Atakishiyev on 10/6/24.
//  Copyright © 2024 orazz.com. All rights reserved.


import CommonCrypto

// MARK: - Protocol

/// Defines the interface for cache keys
protocol IImageCacheKey {
    var stringValue: String { get }
    var hashedValue: String { get }
    func sha256(_ string: String) -> String
}

// MARK: - Implementation

/// A concrete implementation of `IImageCacheKey` using strings
struct StringImageCacheKey: IImageCacheKey {
    /// The string value of the key
    let stringValue: String

    /// Computed property to get a hashed version of the key
    var hashedValue: String {
        return sha256(stringValue)
    }

    /// SHA-256 hash function
    internal func sha256(_ string: String) -> String {
        guard let data = string.data(using: .utf8) else { return "" }
        var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA256($0.baseAddress, CC_LONG(data.count), &hash)
        }
        return hash.map { String(format: "%02x", $0) }.joined()
    }
}
