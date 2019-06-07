//
//  MovieDetailsViewController.swift
//  Movies
//
//  Created by Parul Vats on 04/09/2018.
//  Copyright © 2018 Parul Vats. All rights reserved.
//

import UIKit

protocol MovieDetailsDisplayable: class {
    func display(_ movieDetails: MovieDetailsViewModel)
}

class MovieDetailsViewController: UIViewController, MovieDetailsDisplayable {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    
    // MARK: - Properties
    var interactor: MovieDetailsInteractable?
    var router: (MovieDetailsRoutable & MovieDetailsDataPassing)!
    
    // MARK: - Initializers
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupVIPCycle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupVIPCycle()
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        interactor?.fetchMovieDetails()
    }
    
    // MARK: - Setup
    private func setupVIPCycle() {
        let presenter = MovieDetailsPresenter(viewController: self)
        let interactor = MovieDetailsInteractor(presenter: presenter)
        self.interactor = interactor
        router = MovieDetailsRouter(viewController: self, dataStore: interactor)
    }
    
    private func setupUI() {
        idLabel.text = nil
        nameLabel.text = nil
        descriptionLabel.text = nil
    }
    
    func display(_ movieDetails: MovieDetailsViewModel) {
        idLabel.text = movieDetails.id
        nameLabel.text = movieDetails.name
        descriptionLabel.text = movieDetails.description
    }
}
