//
//  MoviesWorker.swift
//  Movies
//
//  Created by Parul Vats on 29/04/2018.
//  Copyright © 2018 Parul Vats. All rights reserved.
//

import Foundation

protocol MoviesWorkerDelegate {
    func moviesWorker(_ MoviesWorker: MoviesWorker, didFetchMovies movies: [Movie])
}

protocol MoviesDataProvidable {
    func fetchMovies(completionHandler: @escaping ([Movie]) -> Void)
}

class MoviesWorker: MoviesDataProvidable, MovieAPIDelegate {
    
    private var movieAPI: MovieAPIProtocol
    
    init(movieAPI: MovieAPIProtocol = MovieAPI()) {
        self.movieAPI = movieAPI
    }
    
    // MARK: - Block implementation
    
    func fetchMovies(completionHandler: @escaping ( [Movie]) -> Void) {
        movieAPI.fetch(completionHandler: completionHandler)
    }
    
    // MARK: - Delegate implementation
    
    var delegate: MoviesWorkerDelegate?
    
    func fetchMovies() {
        movieAPI.delegate = self
        movieAPI.fetch()
    }
    
    func movieAPI(_ movieAPI: MovieAPIProtocol, didFetchMovies movies: [Movie]) {
        delegate?.moviesWorker(self, didFetchMovies: movies)
    }
}
