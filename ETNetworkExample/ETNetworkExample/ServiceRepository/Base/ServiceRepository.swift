//
//  ServiceRepository.swift
//  ETNetworkExample
//
//  Created by Emrah Turan on 15.01.2024.
//

import Foundation
import ETNetwork

final class ServiceRepository {
    static let shared = ServiceRepository()

    private let network = ETNetwork.shared.network

    func get<T, U>(endpoint: String,
                   request: U,
                   completion: @escaping (Result<T>) -> Void) where T: Decodable, U: Encodable {

        network.get(endpoint: endpoint,
                    request: request,
                    headerFields: getRequestHeaderFields()) { (result: NetworkResult<T>) in

            switch result {
            case .success(let data, _):
                do {
                    guard let data = data as? Data else {
                        onMain {
                            completion(.failure(error: "noData"))
                        }
                        return
                    }

                    let decodedData = try JSONDecoder().decode(T.self, from: data)

                    onMain {
                        completion(.success(data: decodedData))
                    }
                } catch {
                    onMain {
                        completion(.failure(error: "Decode"))
                    }
                }
            case .failure(let error, _):
                onMain {
                    completion(.failure(error: error.customMessage))
                }
            }
        }
    }
}

private extension ServiceRepository {
    func getRequestHeaderFields() -> [String: String] {
        var headerFields: [String: String] = [:]
        let bearerToken = ""

        headerFields["Accept"] = "application/json; charset=utf-8"
        headerFields["Content-Type"] = "application/json; charset=utf-8"
        headerFields["Authorization"] = "Bearer \(bearerToken)"

        return headerFields
    }
}
