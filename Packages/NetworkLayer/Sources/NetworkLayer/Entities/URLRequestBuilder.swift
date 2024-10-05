//
//  URLRequestBuilder.swift
//  NetworkLayer
//
//  Created by Oraz Atakishiyev on 10/4/24.
//  Copyright © 2024 orazz.com. All rights reserved.

import Foundation

protocol IURLRequestBuilder {
    func build(forReuqest request: INetworkRequest) -> URLRequest
}

struct URLRequestBuilder: IURLRequestBuilder {
    var baseURL: URL

    func build(forReuqest request: any INetworkRequest) -> URLRequest {
        let url = baseURL.appending(path: request.path)

        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.header

        urlRequest.add(parameters: request.parameters)

        if let contentType = request.parameters.contentType {
            urlRequest.add(header: .contentType(contentType))
        }

        return urlRequest
    }
}

extension URLRequest {
    mutating func add(header: HeaderField) {
        setValue(header.value, forHTTPHeaderField: header.key)
    }

    /// Add parameters
    /// - Parameter parameters: RequestParameter
    mutating func add(parameters: Parameters) {
        switch parameters {
        case .none:
            break
        case .url(let dictionary):
            guard let url = url, var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { break }
            components = components.setParameters(dictionary)
            guard let newUrl = components.url else { break }
            self.url = newUrl

        case .json(let dictionary):
            httpBody = try? JSONSerialization.data(withJSONObject: dictionary)
        case .data(let data, _):
            httpBody = data
        }
    }
}
