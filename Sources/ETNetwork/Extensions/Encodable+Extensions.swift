//
//  Encodable+Extensions.swift
//  ETNetwork
//
//  Created by Emrah Turan on 14.01.2024.
//

import Foundation

extension Encodable {
    var toUrlQueryItems: [URLQueryItem] {
        let encoder = JSONEncoder()

        if let array = (try? JSONSerialization.jsonObject(with: encoder.encode(self))) as? [String: Any] {
            var values: [URLQueryItem] = []

            for (key, value) in array {
                values.append(URLQueryItem(name: key, value: "\(value)"))
            }

            return values
        }

        return []
    }
}
