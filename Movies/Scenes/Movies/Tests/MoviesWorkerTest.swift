//
//  MoviesWorkerTest.swift
//  MoviesTests
//
//  Created by Parul Vats on 23/05/2018.
//  Copyright © 2018 Parul Vats. All rights reserved.
//

import XCTest
@testable import Movies

class MoviesWorkerTest: XCTestCase {
    
    // MARK: Test doubles
    
    class MovieAPISpy: MovieAPIProtocol {
        let movies = Seeds.Movies.all

        var fetchWithCompletionHandlerCalled = false
        var fetchWithDelegateCalled = false
        var delegate: MovieAPIDelegate?

        func fetch(completionHandler: @escaping ([Movie]) -> Void) {
            fetchWithCompletionHandlerCalled = true
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                completionHandler(self.movies)
            }
        }

        func fetch() {
            fetchWithDelegateCalled = true
        }
    }
    
    class MoviesWorkerDelegateSpy: MoviesWorkerDelegate {
        var moviesWorkerDidFetchMoviesCalled = false
        var moviesWorkerDidFetchMoviesResults: [Movie]?
        
        func moviesWorker(_ MoviesWorker: MoviesWorker, didFetchMovies movies: [Movie]) {
            moviesWorkerDidFetchMoviesCalled = true
            moviesWorkerDidFetchMoviesResults = movies
        }
    }
    
    // MARK: Block implementation
    
    func testFetchShouldAskMovieAPIToFetchMoviesWithBlock() {
        // Given
        let movieAPISpy = MovieAPISpy()
        let sut = MoviesWorker(movieAPI: movieAPISpy)
        
        // When
        sut.fetchMovies { _ in }
        
        // Then
        XCTAssertTrue(movieAPISpy.fetchWithCompletionHandlerCalled, "fetchMovies(completionHandler:) should ask Movie API to fetch movies")
    }
    
    func testFetchShouldReturnMoviesResultsToBlock() {
        // Given
        let movieAPISpy = MovieAPISpy()
        let sut = MoviesWorker(movieAPI: movieAPISpy)
        
        // When
        var actualMovies: [Movie]?
        let fetchCompleted = expectation(description: "Wait for fetch to complete")
        sut.fetchMovies { movies in
            actualMovies = movies
            fetchCompleted.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
        
        // Then
        let expectedMovies = movieAPISpy.movies
        XCTAssertNotNil(actualMovies, "fetchMovies(completionHandler:) should return an array of movies to completion block if the fetch succeeds")
        XCTAssertEqual(actualMovies!.count, expectedMovies.count)
        XCTAssertEqual(actualMovies!, expectedMovies, "fetchMovies() should return an array of movies if the fetch succeeds")
    }
    
    // MARK: Delegate implementation
    
    func testFetchShouldAskMovieAPIToFetchMoviesWithDelegate() {
        // Given
        let movieAPISpy = MovieAPISpy()
        let sut = MoviesWorker(movieAPI: movieAPISpy)
        
        // When
        sut.fetchMovies()
        
        // Then
        XCTAssertTrue(movieAPISpy.fetchWithDelegateCalled, "fetchMovies() should ask Movie API to fetch movies")
    }
    
    func testMovieAPIDidFetchMovesShouldNotifyDelegateWithMoviesResults() {
        // Given
        let moviesWorkerDelegateSpy = MoviesWorkerDelegateSpy()
        let movieAPISpy = MovieAPISpy()
        let sut = MoviesWorker(movieAPI: movieAPISpy)
        sut.delegate = moviesWorkerDelegateSpy
        
        // When
        sut.movieAPI(movieAPISpy, didFetchMovies: movieAPISpy.movies)
        
        // Then
        let expectedMovies = movieAPISpy.movies
        let actualMovies = moviesWorkerDelegateSpy.moviesWorkerDidFetchMoviesResults
        XCTAssertTrue(moviesWorkerDelegateSpy.moviesWorkerDidFetchMoviesCalled, "fetchMovies() should notify its delegate")
        XCTAssertNotNil(actualMovies, "fetchMovies() should return an array of movies if the fetch succeeds")
        XCTAssertEqual(actualMovies!, expectedMovies, "fetchMovies() should return an array of movies if the fetch succeeds")
    }
}
