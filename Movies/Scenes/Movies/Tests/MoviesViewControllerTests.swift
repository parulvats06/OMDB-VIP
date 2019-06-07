//
//  MoviesViewControllerTests.swift
//  Movies
//
//  Created by Parul Vats on 21/05/2018.
//  Copyright © 2018 Parul Vats. All rights reserved.
//

import XCTest
@testable import Movies

class MoviesViewControllerTests: XCTestCase {
    
    // MARK: - Window
    var window: UIWindow!
    
    // MARK: - Test lifecycle
    override func setUp() {
        super.setUp()
        window = UIWindow()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    // MARK: - Test setup
    func loadView(_ view: UIView) {
        window.addSubview(view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: - Test doubles
    class MoviesInteractorSpy: MoviesInteractable {
        
        var movieId: String?
        var fetchMoviesCalled = false
        var selectMovieAtIndexCalled = false
        
        func fetchMovies() {
            fetchMoviesCalled = true
        }
        
        func selectMovie(at index: Int) {
            selectMovieAtIndexCalled = true
        }
    }
    
    class TableViewSpy: UITableView {
        var reloadDataCalled = false
        
        override func reloadData() {
            reloadDataCalled = true
        }
    }
    
    // MARK: - Tests
    func testShouldFetchMoviesWhenViewDidLoad() {
        // Given
        let moviesInteractorSpy = MoviesInteractorSpy()
        let sut = MoviesViewController()
        sut.interactor = moviesInteractorSpy
        loadView(sut.view)
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssert(moviesInteractorSpy.fetchMoviesCalled, "Should fetch movies when view is loaded")
    }
    
    func testShouldDisplayFetchedMovies() {
        // Given
        let tableViewSpy = TableViewSpy()
        let sut = MoviesViewController()
        sut.tableView = tableViewSpy
        let movies = [MovieViewModel]()
        
        // When
        sut.display(movies)
    
        // Then
        XCTAssert(tableViewSpy.reloadDataCalled, "Displaying fetched movies should reload the table view")
    }
    
    func testNumberOfSectionsInTableViewShouldAlwaysBeOne() {
        // Given
        let sut = MoviesViewController()
        let tableView = sut.tableView
        
        // When
        let numberOfSections = sut.numberOfSections(in: tableView!)
        
        // Then
        XCTAssertEqual(numberOfSections, 1, "The number of table view sections should always be 1")
    }
    
    func testNumberOfRowsInAnySectionShouldEqualNumberOfMoviesToDisplay() {
        // Given
        let sut = MoviesViewController()
        let tableView = sut.tableView
        let movies = [MovieViewModel(from: Seeds.Movies.slumdogMillionaire)]
        sut.display(movies)
        
        // When
        let numberOfRows = sut.tableView(tableView!, numberOfRowsInSection: 1)
        
        // Then
        XCTAssertEqual(numberOfRows, movies.count, "The number of table view rows should equal the number of movies to display")
    }
    
    func testShouldConfigureTableViewCellToDisplayOrder() {
        // Given
        let sut = MoviesViewController()
        let tableView = sut.tableView
        let movies = [MovieViewModel(from: Seeds.Movies.slumdogMillionaire)]
        sut.display(movies)
        
        // When
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView(tableView!, cellForRowAt: indexPath) as! MoviesTableViewCell
        
        // Then
        XCTAssertEqual(cell.titleLabel?.text, Seeds.Movies.slumdogMillionaire.title, "A properly configured table view cell should display the movie title")
        XCTAssertEqual(cell.yearLabel?.text, Seeds.Movies.slumdogMillionaire.releaseDate.convertToDate()?.getYearString(), "A properly configured table view cell should display the movie year")
    }
}
