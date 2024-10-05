//
//  NetworkResponse.swift
//  NetworkLayer
//
//  Created by Oraz Atakishiyev on 10/4/24.
//  Copyright © 2024 orazz.com. All rights reserved.

import Foundation

struct NetworkResponse {
    let data: Data

    init(data: Data, urlResponse: URLResponse) throws {
        guard let httpResponse = urlResponse as? HTTPURLResponse else {
            throw HTTPNetworkServiceError.invalidResponse(urlResponse)
        }

        guard let status = ResponseStatus(rawValue: httpResponse.statusCode), status.isSuccess else {
            throw HTTPNetworkServiceError.invalidStatusCode(httpResponse.statusCode, data)
        }

        self.data = data
    }

    func getData() throws -> Data {
        return data
    }
}
