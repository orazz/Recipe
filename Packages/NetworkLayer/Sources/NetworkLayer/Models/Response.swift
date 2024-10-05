//
//  Response.swift
//  NetworkLayer
//
//  Created by Oraz Atakishiyev on 10/4/24.
//  Copyright © 2024 orazz.com. All rights reserved.

import Foundation

public enum ResponseCode {
    static let informationalCodes = 100..<200
    static let successCodes = 200..<300
    static let redirectCodes = 300..<400
    static let clientErrorCodes = 400..<500
    static let serverErrorCodes = 500..<600
}
