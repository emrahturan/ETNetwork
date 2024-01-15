//
//  PopularMovieService.swift
//  ETNetworkExample
//
//  Created by Emrah Turan on 15.01.2024.
//

import Foundation

protocol PopularMovieServiceProtocol {
    func getPopularMovies(completion: @escaping (Result<EmptyDecodable>) -> Void)
}

extension ServiceRepository: PopularMovieServiceProtocol {
    func getPopularMovies(completion: @escaping (Result<EmptyDecodable>) -> Void) {
        get(endpoint: "https://api.themoviedb.org/3/movie/popular",
            request: EmptyEncodable(),
            completion: completion)
    }
}
