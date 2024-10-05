//
//  URLComponents+setParams.swift
//  NetworkLayer
//
//  Created by Oraz Atakishiyev on 10/4/24.
//  Copyright © 2024 orazz.com. All rights reserved.

import Foundation

extension URLComponents {
    /// Setting params as dictionary and returning URLComponents
    /// - Parameter parameters: URLComponents.
    /// - Returns: new URLComponents with params.
    public func setParameters(_ parameters: [String: Any]) -> URLComponents {
        var urlComponents = self
        urlComponents.queryItems = parameters.map { URLQueryItem(name: $0, value: String(describing: $1)) }
        return urlComponents
    }
}
