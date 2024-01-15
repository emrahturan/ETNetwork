//
//  NetworkErrorHandler.swift
//  ETNetwork
//
//  Created by Emrah Turan on 14.01.2024.
//

import Foundation

final class NetworkErrorHandler {
    static func handleError<T>(_ error: NetworkError,
                               headerFields: [AnyHashable: Any],
                               completion: @escaping (NetworkResult<T>) -> Void) {
        onMain {
            completion(.failure(error: error, headerFields: headerFields))
        }
    }
}
