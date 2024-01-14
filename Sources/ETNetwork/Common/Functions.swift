//
//  Functions.swift
//  ETNetwork
//
//  Created by Emrah Turan on 14.01.2024.
//

import Foundation

func onMain(completion: @escaping () -> Void) {
    DispatchQueue.main.async {
        completion()
    }
}
