//
//  NetworkProtocol.swift
//  ETNetwork
//
//  Created by Emrah Turan on 14.01.2024.
//

import Foundation

protocol NetworkProtocol {
    func get<T: Decodable, U: Encodable>(endpoint: String,
                                         request: U,
                                         headerFields: [String: String],
                                         completion: @escaping (NetworkResult<T>) -> Void)
}
