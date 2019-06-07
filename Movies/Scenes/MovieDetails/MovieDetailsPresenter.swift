//
//  MovieDetailsPresentable.swift
//  Movies
//
//  Created by Parul Vats on 04/09/2018.
//  Copyright © 2018 Parul Vats. All rights reserved.
//

import Foundation

protocol MovieDetailsPresentable {
    func presentDetails(of movie: Movie)
}

class MovieDetailsPresenter: MovieDetailsPresentable {
    
    // MARK: - Properties
    private weak var viewController: MovieDetailsDisplayable?
    
    // MARK: - Init
    init(viewController: MovieDetailsDisplayable) {
        self.viewController = viewController
    }
    
    // MARK: - MovieDetailsPresentable
    func presentDetails(of movie: Movie) {
        let movieDetails = MovieDetailsViewModel(id: movie.imdbId, name: movie.title, description: movie.releaseCountry)
        viewController?.display(movieDetails)
    }
}
