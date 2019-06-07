//
//  MoviesInteractorTests.swift
//  MoviesTests
//
//  Created by Parul Vats on 20/05/2018.
//  Copyright © 2018 Parul Vats. All rights reserved.
//

import XCTest
@testable import Movies

class MoviesInteractorTests: XCTestCase {
    
    // MARK: - Test doubles
    class MoviesPresenterSpy: MoviesPresentable {
    
        var presentMoviesCalled = false
        var movies: [Movie]?
       
        func present(_ movies: [Movie]) {
            presentMoviesCalled = true
            self.movies = movies
        }
    }
    
    class MoviesWorkerSpy: MoviesDataProvidable {
        var fetchMoviesCalled = false
        var movies: [Movie]
        
        init(movies: [Movie] = []) {
            self.movies = movies
        }

        func fetchMovies(completionHandler: @escaping ([Movie]) -> Void) {
            fetchMoviesCalled = true
            completionHandler(movies)
        }
    }
    
    // MARK: - Tests
    func testFetchMoviesCallsWorkerToFetch() {
        // Given
        let moviesWorkerSpy = MoviesWorkerSpy()
        let sut = MoviesInteractor(presenter: MoviesPresenterSpy(), worker: moviesWorkerSpy)
        
        // When
        sut.fetchMovies()
        
        // Then
        XCTAssert(moviesWorkerSpy.fetchMoviesCalled, "fetchMovies() should ask the worker to fetch movies")
    }
    
    func testFetchMoviesCallsPresenterToFormatMovies() {
        // Given
        let moviesPresenterSpy = MoviesPresenterSpy()
        let sut = MoviesInteractor(presenter: moviesPresenterSpy, worker: MoviesWorkerSpy())
        
        // When
        sut.fetchMovies()
        
        // Then
        XCTAssert(moviesPresenterSpy.presentMoviesCalled, "fetchMovies() should ask the presenter to format the movies")
    }
    
    func testFetchMoviesCallsPresenterToFormatFetchedMovies() {
        // Given
        let movies = Seeds.Movies.all
        let moviesPresenterSpy = MoviesPresenterSpy()
        let moviesWorkerSpy = MoviesWorkerSpy(movies: movies)
        let sut = MoviesInteractor(presenter: moviesPresenterSpy, worker: moviesWorkerSpy)
        
        // When
        sut.fetchMovies()
        
        // Then
        XCTAssertEqual(moviesPresenterSpy.movies?.count, movies.count, "fetchMovies() should ask the presenter to format the same amount of movies it fetched")
        XCTAssertEqual(moviesPresenterSpy.movies, movies, "fetchMovies() should ask the presenter to format the same movies it fetched")
    }
}
