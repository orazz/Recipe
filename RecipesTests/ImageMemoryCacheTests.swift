//
//  ImageMemoryCacheTests.swift
//  Recipes
//
//  Created by Oraz Atakishiyev on 10/6/24.
//  Copyright © 2024 orazz.com. All rights reserved.

import XCTest
@testable import Recipes

class MemoryImageCacheTests: XCTestCase {

    var sut: MemoryImageCache<UIImage>!

    override func setUp() {
        super.setUp()
        sut = MemoryImageCache()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testSetAndGetImage() {
        // Given
        let key = StringImageCacheKey(stringValue: "testImage")
        let image = UIImage(systemName: "star.fill")!

        // When
        sut.setImage(image, for: key)
        let retrievedImage = sut.image(for: key)

        // Then
        XCTAssertNotNil(retrievedImage, "Retrieved image should not be nil")
        XCTAssertEqual(image.pngData(), retrievedImage?.pngData(), "Retrieved image should be the same as the original")
    }

    func testGetNonExistentImage() {
        // Given
        let key = StringImageCacheKey(stringValue: "testImage")

        // When
        let retrievedImage = sut.image(for: key)

        // Then
        XCTAssertNil(retrievedImage, "Retrieved image should be nil for non-existent key")
    }

    func testContainsImage() {
        // Given
        let key = StringImageCacheKey(stringValue: "testImage")
        let image = UIImage(systemName: "star.fill")!

        // When
        sut.setImage(image, for: key)

        // Then
        XCTAssertTrue(sut.containsImage(for: key), "Cache should contain the image")
        XCTAssertFalse(sut.containsImage(for: StringImageCacheKey(stringValue: "nonexistentImage")), "Cache should not contain non-existent image")
    }

    func testRemoveImage() {
        // Given
        let key = StringImageCacheKey(stringValue: "testImage")
        let image = UIImage(systemName: "star.fill")!
        sut.setImage(image, for: key)

        // When
        sut.removeImage(for: key)

        // Then
        XCTAssertFalse(sut.containsImage(for: key), "Cache should not contain the image after removal")
        XCTAssertNil(sut.image(for: key), "Retrieved image should be nil after removal")
    }

    func testClearCache() {
        // Given
        let key1 = StringImageCacheKey(stringValue: "testImage1")
        let key2 = StringImageCacheKey(stringValue: "testImage2")
        let image = UIImage(systemName: "star.fill")!
        sut.setImage(image, for: key1)
        sut.setImage(image, for: key2)

        // When
        sut.clearCache()

        // Then
        XCTAssertFalse(sut.containsImage(for: key1), "Cache should not contain image1 after clearing")
        XCTAssertFalse(sut.containsImage(for: key2), "Cache should not contain image2 after clearing")
    }

}
