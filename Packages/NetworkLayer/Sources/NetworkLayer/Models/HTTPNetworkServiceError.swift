//
//  HTTPNetworkServiceError.swift
//  NetworkLayer
//
//  Created by Oraz Atakishiyev on 10/4/24.
//  Copyright © 2024 orazz.com. All rights reserved.

import Foundation

public enum HTTPNetworkServiceError: Error {
    /// Network error.
    case networkError(Error)
    /// The response have unexpected format.
    case invalidResponse(URLResponse?)
    /// The status code is not on a success range `(200..<300)`.
    case invalidStatusCode(Int, Data?)
    /// Data missing
    case noData
    /// Failed to decode data
    case failedToDecodeResponse(Error)
}
