//
//  MoviesInteractor.swift
//  Movies
//
//  Created by Parul Vats on 28/04/2018.
//  Copyright © 2018 Parul Vats. All rights reserved.
//

import Foundation

protocol MoviesInteractable {
    func fetchMovies()
}

protocol MoviesDataStore {
    var movies: [Movie] { get }
}

class MoviesInteractor: MoviesInteractable, MoviesDataStore {
    
    // MARK: - Properties
    var movies: [Movie] = []
    private var presenter: MoviesPresentable
    private var worker: MoviesDataProvidable
    
    // MARK: - Init
    init(presenter: MoviesPresentable, worker: MoviesDataProvidable = MoviesWorker()) {
        self.presenter = presenter
        self.worker = worker
    }
    
    // MARK: - MoviesInteractable
    func fetchMovies() {
        worker.fetchMovies { [weak self] (movies) -> Void in
            self?.movies = movies
            self?.presenter.present(movies)
        }
    }
}

