//
//  ETNetworkResult.swift
//  ETNetwork
//
//  Created by Emrah Turan on 14.01.2024.
//

import Foundation

public enum NetworkResult<T> {
    case success(data: T, headerFields: [AnyHashable: Any])
    case failure(error: NetworkError, headerFields: [AnyHashable: Any])
}
