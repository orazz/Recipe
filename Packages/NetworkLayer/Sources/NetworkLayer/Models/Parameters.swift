//
//  Parameters.swift
//  NetworkLayer
//
//  Created by Oraz Atakishiyev on 10/4/24.
//  Copyright © 2024 orazz.com. All rights reserved.

import Foundation

public enum Parameters {
    /// No paramsт.
    case none
    /// Key value parameters for get requests.
    case url([String: Any])
    /// JSON request has json body.
    case json([String: Any])
    /// Binary data.
    case data(Data, ContentType)

    public var contentType: ContentType? {
        switch self {
        case .none, .url:
            return nil
        case let .data(_, type):
            return type
        case .json:
            return .json
        }
    }
}
