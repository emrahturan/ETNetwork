//
//  NetworkError.swift
//  ETNetwork
//
//  Created by Emrah Turan on 14.01.2024.
//

import Foundation

public enum NetworkError: Error {
    case decode
    case invalidURL
    case invalidData
    case noResponse
    case unauthorized
    case notFound
    case unexpectedStatusCode
    case badRequest
    case serverError
    case encode
    case notConnectedToInternet

    // TODO: Edit returning messages
    public var customMessage: String {
        switch self {
        case .decode:
            return "An unexpected error occurred. W001"
        case .invalidURL:
            return "An unexpected error occurred. W002"
        case .invalidData:
            return "An unexpected error occurred. W003"
        case .noResponse:
            return "An unexpected error occurred. W004"
        case .badRequest:
            return "An unexpected error occurred. W005"
        case .unauthorized:
            return "An unexpected error occurred. W006"
        case .notFound:
            return "An unexpected error occurred. W007"
        case .serverError:
            return "An unexpected error occurred. W008"
        case .unexpectedStatusCode:
            return "An unexpected error occurred. W009"
        case .encode:
            return "An unexpected error occurred. W010"
        case .notConnectedToInternet:
            return "Not Connected To Internet"
        }
    }
}
