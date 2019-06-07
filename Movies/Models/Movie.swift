//
//  Movie.swift
//  Movies
//
//  Created by Parul Vats on 28/04/2018.
//  Copyright © 2018 Parul Vats. All rights reserved.
//

import Foundation

struct Movie: Codable, Equatable {
    let imdbId: String
    let title: String
    let releaseDate: String
    let releaseCountry: String
    let runtime: Int
}
