//
//  MoviesRouter.swift
//  Movies
//
//  Created by Parul Vats on 04/09/2018.
//  Copyright © 2018 Parul Vats. All rights reserved.
//

import UIKit

protocol MoviesRoutable {
    func routeToDetailsOfMovie(withIndex index: Int)
}

protocol MoviesDataPassing {
     var dataStore: MoviesDataStore { get }
}

class MoviesRouter: MoviesRoutable, MoviesDataPassing {
    
    // MARK: - Properties
    var dataStore: MoviesDataStore
    private weak var viewController: MoviesViewController?
    
    // MARK: - Init
    init(viewController: MoviesViewController, dataStore: MoviesDataStore) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
    
    // MARK: - Routing
    func routeToDetailsOfMovie(withIndex index: Int) {
        let destinationVC = MovieDetailsViewController(nibName: "MovieDetailsViewController", bundle: nil)
        var destinationDS = destinationVC.router.dataStore
        passDataToDetails(source: dataStore, destination: &destinationDS, movieIndex: index)
        navigateToDetails(source: viewController!, destination: destinationVC)
    }
    
    // MARK: - Navigation
    
    func navigateToDetails(source: MoviesViewController, destination: MovieDetailsViewController) {
        source.show(destination, sender: nil)
    } 
    
    // MARK: - Passing data
    
    func passDataToDetails(source: MoviesDataStore, destination: inout MovieDetailsDataStore, movieIndex: Int) {
        let selectedMovie = source.movies[movieIndex]
        destination.movie = selectedMovie
    }
}
