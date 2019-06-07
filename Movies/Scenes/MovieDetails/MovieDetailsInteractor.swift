//
//  MovieDetailsInteractor.swift
//  Movies
//
//  Created by Parul Vats on 04/09/2018.
//  Copyright © 2018 Parul Vats. All rights reserved.
//

import Foundation

protocol MovieDetailsInteractable {
    func fetchMovieDetails()
}

protocol MovieDetailsDataStore {
    var movie: Movie! { get set }
}

class MovieDetailsInteractor: MovieDetailsInteractable, MovieDetailsDataStore {
    
    // MARK: - Properties
    var movie: Movie!
    private var presenter: MovieDetailsPresentable
    
    // MARK: - Init
    init(presenter: MovieDetailsPresentable) {
        self.presenter = presenter
    }
    
    // MARK: - MovieDetailsInteractable
    func fetchMovieDetails() {
        guard let movie = movie else {
            return
        }
        
        presenter.presentDetails(of: movie)
    }
}

