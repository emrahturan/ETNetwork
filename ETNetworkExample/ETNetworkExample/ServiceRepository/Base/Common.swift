//
//  Common.swift
//  ETNetworkExample
//
//  Created by Emrah Turan on 15.01.2024.
//

import Foundation

struct EmptyEncodable: Encodable {}
struct EmptyDecodable: Decodable {}

enum Result<T> {
    case success(data: T)
    case failure(error: String)
}

func onMain(completion: @escaping () -> Void) {
    DispatchQueue.main.async {
        completion()
    }
}
