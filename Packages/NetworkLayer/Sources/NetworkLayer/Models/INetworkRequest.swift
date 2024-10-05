//
//  INetrowkRequest.swift
//  NetworkLayer
//
//  Created by Oraz Atakishiyev on 10/4/24.
//  Copyright © 2024 orazz.com. All rights reserved.

import Foundation

public protocol INetworkRequest {
    /// Request path
    var path: String { get }
    /// HTTP Method, request type
    var method: HTTPMethod { get }
    /// HTTP headers
    var header: HTTPHeader? { get }
    /// Request parameters
    var parameters: Parameters { get }
}

extension INetworkRequest {
    public var header: HTTPHeader? { nil }
}
