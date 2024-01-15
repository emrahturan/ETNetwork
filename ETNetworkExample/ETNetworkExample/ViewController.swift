//
//  ViewController.swift
//  ETNetworkExample
//
//  Created by Emrah Turan on 15.01.2024.
//

import UIKit
import ETNetwork

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        callService()
    }
}

private extension ViewController {
    func callService() {
        let network: PopularMovieServiceProtocol = ServiceRepository()
        network.getPopularMovies { _ in

        }
    }
}
