//
//  MoviesPresenter.swift
//  Movies
//
//  Created by Parul Vats on 28/04/2018.
//  Copyright © 2018 Parul Vats. All rights reserved.
//

import Foundation

protocol MoviesPresentable {
    func present(_ movies: [Movie])
}

class MoviesPresenter: MoviesPresentable {
    
    // MARK: - Properties
    private weak var viewController: MoviesDisplayable?
    
    // MARK: - Init
    init(viewController: MoviesDisplayable) {
        self.viewController = viewController
    }
    
    // MARK: - MoviesDisplayable
    func present(_ movies: [Movie]) {
        let movies = movies.map { MovieViewModel(from: $0) }
        viewController?.display(movies)
    }
}
