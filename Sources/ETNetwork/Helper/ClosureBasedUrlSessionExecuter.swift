//
//  ClosureBasedUrlSessionExecuter.swift
//  ETNetwork
//
//  Created by Emrah Turan on 14.01.2024.
//

import Foundation

final class ClosureBasedUrlSessionExecuter: ExecuterProtocol {
    private let session: URLSession

    init(_ session: URLSession = NetworkDefaults().configure()) {
        self.session = session
    }

    func execute<T>(_ url: URLRequest,
                    completion: @escaping (NetworkResult<T>) -> Void) -> URLSessionDataTask where T: Decodable {

        return session.dataTask(with: url) { data, response, error in

            if let error = error as? URLError, error.code == .notConnectedToInternet {
                NetworkErrorHandler.handleError(.notConnectedToInternet, headerFields: [:], completion: completion)
                return
            }

            guard let response = response as? HTTPURLResponse else {
                NetworkErrorHandler.handleError(.noResponse, headerFields: [:], completion: completion)
                return
            }

            self.networkLogger(request: url, response: response, data: data, error: error)

            guard let data = data else {
                NetworkErrorHandler.handleError(.invalidData, headerFields: response.allHeaderFields, completion: completion)
                return
            }

            switch response.statusCode {
            case 200...299:
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)

                    onMain {
                        completion(.success(data: decodedData, headerFields: response.allHeaderFields))
                    }
                } catch {
                    NetworkErrorHandler.handleError(.decode, headerFields: response.allHeaderFields, completion: completion)
                }
                return
            case 400:
                NetworkErrorHandler.handleError(.badRequest, headerFields: response.allHeaderFields, completion: completion)
                return
            case 401:
                NetworkErrorHandler.handleError(.unauthorized, headerFields: response.allHeaderFields, completion: completion)
                return
            case 404:
                NetworkErrorHandler.handleError(.notFound, headerFields: response.allHeaderFields, completion: completion)
                return
            case 500:
                NetworkErrorHandler.handleError(.serverError, headerFields: response.allHeaderFields, completion: completion)
                return
            default:
                NetworkErrorHandler.handleError(.unexpectedStatusCode, headerFields: response.allHeaderFields, completion: completion)
                return
            }
        }
    }
}

// MARK: - Logger
private extension ClosureBasedUrlSessionExecuter {
    func networkLogger(request: URLRequest, response: HTTPURLResponse?, data: Data?, error: Error?) {
        var output = "\n - - - - - - - - - Network Log Start - - - - - - - - - - \n"

        let urlStr: String = request.url?.absoluteString ?? ""
        let method: String = request.httpMethod ?? ""
        let statusCode: String = "\(response?.statusCode ?? 0)"

        output += "REQUEST" + "\n"
        output += "[\(method)] - \(urlStr)" + "\n"

        if let headerFields = request.allHTTPHeaderFields {
            output += "\n" + "HEADER" + "\n"

            for (key, value) in headerFields {
                output += "\(key): \(value)" + "\n"
            }
        }

        if let body = request.httpBody {
            output += "\n" + "BODY" + "\n" + "\(String(data: body, encoding: .utf8) ?? "")" + "\n"
        }

        output += "\n" + "RESPONSE" + "\n" + "[HTTP \(statusCode)]" + "\n"

        if let headerFields = response?.allHeaderFields {
            output += "\n" + "HEADER" + "\n"

            for (key, value) in headerFields {
                output += "\(key): \(value)" + "\n"
            }
        }

        if let body = data {
            output += "\n" + "BODY" + "\n" + "\(String(data: body, encoding: .utf8) ?? "")" + "\n"
        }

        if error != nil {
            output += "\n" + "ERROR:" + "\(error?.localizedDescription ?? "-")" + "\n"
        }

        output += "\n - - - - - - - - - Network Log End - - - - - - - - - - - \n"

        print(output)
    }
}
