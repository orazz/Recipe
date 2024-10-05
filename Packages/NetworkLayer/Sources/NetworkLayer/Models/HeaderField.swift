//
//  HeaderField.swift
//  NetworkLayer
//
//  Created by Oraz Atakishiyev on 10/4/24.
//  Copyright © 2024 orazz.com. All rights reserved.

public typealias HTTPHeader = [String: String]

public enum HeaderField {
    /// Type of content
    case contentType(ContentType)

    /// Name of key in header
    public var key: String {
        switch self {
        case .contentType:
            return "Content-Type"
        }
    }

    /// Value of header
    public var value: String {
        switch self {
        case .contentType(let contentType):
            return contentType.value
        }
    }
}
