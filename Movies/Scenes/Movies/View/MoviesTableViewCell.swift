//
//  MoviesTableViewCell.swift
//  Movies
//
//  Created by Parul Vats on 02/05/2018.
//  Copyright © 2018 Parul Vats. All rights reserved.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = .black
        }
    }
    @IBOutlet weak var yearLabel: UILabel! {
        didSet {
            yearLabel.textColor = .gray
        }
    }
    
    // MARK: - Setup
    func configure(with movie: MovieViewModel) {
        titleLabel?.text = movie.title
        yearLabel?.text = movie.year
    }
}
