//
//  MovieViewModel.swift
//  Movies
//
//  Created by Parul Vats on 05/09/2018.
//  Copyright © 2018 Parul Vats. All rights reserved.
//

import Foundation

struct MovieViewModel: Equatable {
    let title: String
    let year: String
}

extension MovieViewModel {
    init(from movie: Movie) {
        title = movie.title
        
        if let date = movie.releaseDate.convertToDate() {
            year = date.getYearString()
        } else {
            year = "Unknown"
        }
    }
}
