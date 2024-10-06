//
//  DiskImageTests.swift
//  Recipes
//
//  Created by Oraz Atakishiyev on 10/6/24.
//  Copyright © 2024 orazz.com. All rights reserved.


import XCTest
@testable import Recipes

class DiskImageCacheTests: XCTestCase {

    var cache: DiskImageCache!
    let testImageURL = URL(string: "https://example.com/test-image.jpg")!

    override func setUp() {
        super.setUp()
        cache = DiskImageCache(cacheName: "TestCache")
    }

    override func tearDown() {
        cache.clearCache()
        cache = nil
        super.tearDown()
    }

    func testSetAndGetImage() {
        let expectation = XCTestExpectation(description: "Set and get image")

        let testImage = UIImage(systemName: "star.fill")! // Use a system image for testing
        let key = StringImageCacheKey(stringValue: testImageURL.absoluteString)

        cache.setImage(testImage, for: key)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let retrievedImage = self.cache.image(for: key) {
                XCTAssertNotNil(retrievedImage, "Retrieved image should not be nil")
                expectation.fulfill()
            } else {
                XCTFail("Failed to retrieve image")
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testRemoveImage() {
        let expectation = XCTestExpectation(description: "Remove image")

        let testImage = UIImage(systemName: "star.fill")!
        let key = StringImageCacheKey(stringValue: testImageURL.absoluteString)

        cache.setImage(testImage, for: key)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.cache.removeImage(for: key)

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                let retrievedImage = self.cache.image(for: key)
                XCTAssertNil(retrievedImage, "Image should be nil after removal")
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testContainsImage() {
        let expectation = XCTestExpectation(description: "Contains image")

        let testImage = UIImage(systemName: "star.fill")!
        let key = StringImageCacheKey(stringValue: testImageURL.absoluteString)

        cache.setImage(testImage, for: key)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(self.cache.containsImage(for: key), "Cache should contain the image")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testClearCache() {
        let expectation = XCTestExpectation(description: "Clear cache")

        let testImage = UIImage(systemName: "star.fill")!
        let key = StringImageCacheKey(stringValue: testImageURL.absoluteString)

        cache.setImage(testImage, for: key)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.cache.clearCache()

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                XCTAssertFalse(self.cache.containsImage(for: key), "Cache should not contain the image after clearing")
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }
}
