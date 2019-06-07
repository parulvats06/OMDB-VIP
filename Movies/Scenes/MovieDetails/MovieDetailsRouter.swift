//
//  MovieDetailsRouter.swift
//  Movies
//
//  Created by Parul Vats on 04/09/2018.
//  Copyright © 2018 Parul Vats. All rights reserved.
//

protocol MovieDetailsRoutable {
    
}

protocol MovieDetailsDataPassing {
    var dataStore: MovieDetailsDataStore { get }
}

class MovieDetailsRouter: MovieDetailsRoutable, MovieDetailsDataPassing {
    
    // MARK: Properties
    weak var viewController: MovieDetailsViewController?
    var dataStore: MovieDetailsDataStore
    
    // MARK: - Init
    init(viewController: MovieDetailsViewController, dataStore: MovieDetailsDataStore) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
}
