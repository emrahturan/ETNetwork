//
//  ETNetwork.swift
//  ETNetwork
//
//  Created by Emrah Turan on 14.01.2024.
//

import Foundation

public class ETNetwork {
    public static let shared = ETNetwork()

    private init() {}

    public let network = NetworkManager(with: ClosureBasedUrlSessionExecuter())
}
