//
//  ContentType.swift
//  NetworkLayer
//
//  Created by Oraz Atakishiyev on 10/4/24.
//  Copyright © 2024 orazz.com. All rights reserved.

public enum ContentType {
    case json

    public var value: String {
        switch self {
        case .json:
            return "application/json"
        }
    }
}
