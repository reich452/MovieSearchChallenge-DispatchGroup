//
//  MovieTableViewCell.swift
//  MovieSearchChallenge
//
//  Created by Nick Reichard on 2/24/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var ratingNameLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieDescriptionTextView: UITextView!
    
    // MARK: - Properties
    
    var movie: Movie? {
        didSet {
            self.updateViews()
        }
    }
    
    // MARK: - Update View
    
    func updateViews() {
        
        guard let movie = movie else { return }
        
        DispatchQueue.main.async {
            self.movieNameLabel.text = movie.movieTitle
            self.movieDescriptionTextView.text = movie.overview
            self.ratingNameLabel.text = "\(movie.rating)"
            self.posterImage.image = movie.image
            
        }
    }
}
