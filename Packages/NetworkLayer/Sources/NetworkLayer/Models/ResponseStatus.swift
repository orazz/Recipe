//
//  ResponseStatus.swift
//  NetworkLayer
//
//  Created by Oraz Atakishiyev on 10/4/24.
//  Copyright © 2024 orazz.com. All rights reserved.

import Foundation

/// Server request codes
public enum ResponseStatus {
    /// Info status.
    case information(Int)
    /// Success request.
    case success(Int)
    /// Redirected.
    case redirect(Int)
    /// Client error.
    case clientError(Int)
    /// Server error.
    case serverError(Int)

    init?(rawValue: Int) {
        switch rawValue {
        case ResponseCode.informationalCodes:
            self = .information(rawValue)
        case ResponseCode.successCodes:
            self = .success(rawValue)
        case ResponseCode.redirectCodes:
            self = .redirect(rawValue)
        case ResponseCode.clientErrorCodes:
            self = .clientError(rawValue)
        case ResponseCode.serverErrorCodes:
            self = .serverError(rawValue)
        default:
            return nil
        }
    }

    /// Return true if the status success.
    var isSuccess: Bool {
        switch self {
        case .success:
            return true
        default:
            return false
        }
    }
}
