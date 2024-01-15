//
//  ExecuterProtocol.swift
//  ETNetwork
//
//  Created by Emrah Turan on 14.01.2024.
//

import Foundation

protocol ExecuterProtocol {
    func execute<T>(_ url: URLRequest, completion: @escaping (NetworkResult<T>) -> Void) -> URLSessionDataTask where T: Decodable
}
