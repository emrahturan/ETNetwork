//
//  NetworkManager.swift
//  ETNetwork
//
//  Created by Emrah Turan on 14.01.2024.
//

import Foundation

public class NetworkManager: NetworkProtocol {
    private let executer: ExecuterProtocol

    init(with executer: ExecuterProtocol) {
        self.executer = executer
    }

    public func get<T, U>(endpoint: String,
                          request: U,
                          headerFields: [String: String],
                          completion: @escaping (NetworkResult<T>) -> Void) where T: Decodable, U: Encodable {

        var components = URLComponents(string: endpoint)
        components?.queryItems = request.toUrlQueryItems

        guard let url = components?.url else {
            NetworkErrorHandler.handleError(.invalidURL, headerFields: [:], completion: completion)
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.GET.rawValue
        urlRequest.allHTTPHeaderFields = headerFields

        executer.execute(urlRequest, completion: completion).resume()
    }
}
