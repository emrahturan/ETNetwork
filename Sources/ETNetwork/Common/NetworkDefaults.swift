//
//  NetworkDefaults.swift
//  ETNetwork
//
//  Created by Emrah Turan on 14.01.2024.
//

import Foundation

final class NetworkDefaults: NSObject, URLSessionDelegate {
    func configure() -> URLSession {
        let configuration = URLSessionConfiguration.default

        configuration.timeoutIntervalForRequest = 10 // TODO: move to ETNetwork.swift, public
        configuration.timeoutIntervalForResource = 10 // TODO: move to ETNetwork.swift, public
        configuration.waitsForConnectivity = true
        configuration.urlCache = .shared

        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }
}
