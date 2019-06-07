//
//  MoviesPresenterTests.swift
//  Movies
//
//  Created by Parul Vats on 21/05/2018.
//  Copyright © 2018 Parul Vats. All rights reserved.
//

import XCTest
@testable import Movies

class MoviesPresenterTests: XCTestCase {
    
    // MARK: - Test doubles
    class MoviesViewControllerSpy: MoviesDisplayable {
        
        var displayFetchedMoviesCalled = false
        var movies: [MovieViewModel] = []
        
        func display(_ movies: [MovieViewModel]) {
            displayFetchedMoviesCalled = true
            self.movies = movies
        }
    }
    
    // MARK: - Tests
    func testDisplayFetchedMoviesCalledByPresenter() {
        // Given
        let moviesViewControllerSpy = MoviesViewControllerSpy()
        let sut = MoviesPresenter(viewController: moviesViewControllerSpy)
        
        // When
        sut.present([])
        
        // Then
        XCTAssert(moviesViewControllerSpy.displayFetchedMoviesCalled, "presentFetchedMovies() should ask the view controller to display them")
    }
    
    func testPresentFetchedMoviesShouldFormatFetchedMoviesForDisplay() {
        // Given
        let moviesViewControllerSpy = MoviesViewControllerSpy()
        let sut = MoviesPresenter(viewController: moviesViewControllerSpy)
        let movies = Seeds.Movies.all
        
        // When
        sut.present(movies)
        
        // Then
        let displayedMovies = moviesViewControllerSpy.movies
        XCTAssertEqual(displayedMovies.count, movies.count, "presentFetchedMovies() should ask the view controller to display same amount of movies it receive")
        for (index, displayedMovie) in displayedMovies.enumerated() {
            XCTAssertEqual(displayedMovie, MovieViewModel(from: movies[index]))
        }
    }

}
