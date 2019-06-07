//
//  MoviesViewModelTest.swift
//  MoviesTests
//
//  Created by Parul Vats on 23/05/2018.
//  Copyright © 2018 Parul Vats. All rights reserved.
//

import XCTest
@testable import Movies

class MoviesViewModelTest: XCTestCase {
    
    func testCreateMovieViewModelFromMovie() {
        // Given
        let movie = Seeds.Movies.slumdogMillionaire
        
        // When
        let moviesViewModel = MovieViewModel(from: movie)
        
        // Then
        XCTAssertEqual(moviesViewModel.title, movie.title)
        XCTAssertEqual(moviesViewModel.year, movie.releaseDate.convertToDate()?.getYearString())
    }
    
    func testCreateMovieViewModelFromMovieWithWrongReleaseDate() {
        // Given
        let movie = Seeds.Movies.kingsSpeech
        
        // When
        let moviesViewModel = MovieViewModel(from: movie)
        
        // Then
        XCTAssertEqual(moviesViewModel.title, movie.title)
        XCTAssertEqual(moviesViewModel.year, "Unknown")
    }
}
