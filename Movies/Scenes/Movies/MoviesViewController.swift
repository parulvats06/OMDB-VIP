//
//  MoviesViewController.swift
//  Movies
//
//  Created by Parul Vats on 28/04/2018.
//  Copyright © 2018 Parul Vats. All rights reserved.
//

import UIKit

protocol MoviesDisplayable: class {
    func display(_ movies: [MovieViewModel])
}

class MoviesViewController: UITableViewController, MoviesDisplayable {

    // MARK: - Properties
    var interactor: MoviesInteractable?
    var router: (MoviesRoutable & MoviesDataPassing)?
    
    private var displayedMovies: [MovieViewModel] = []

    // MARK: - Initializers
    override init(nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupVIPCycle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupVIPCycle()
    }
    
    // MARK: - Setup
    private func setupVIPCycle() {
        let presenter = MoviesPresenter(viewController: self)
        let interactor = MoviesInteractor(presenter: presenter)
        self.interactor = interactor
        router = MoviesRouter(viewController: self, dataStore: interactor)
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MoviesTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        interactor?.fetchMovies()
    }
    
    func display(_ movies: [MovieViewModel]) {
        displayedMovies = movies
        tableView.reloadData()
    }
    
    // MARK: - User actions
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToDetailsOfMovie(withIndex: indexPath.row)
    }
    
    // MARK: - TableView datasource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedMovies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let displayedMovie = displayedMovies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MoviesTableViewCell
        cell.configure(with: displayedMovie)
        return cell
    }
}
