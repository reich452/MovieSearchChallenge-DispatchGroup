//
//  Movie.swift
//  MovieSearchChallenge
//
//  Created by Nick Reichard on 2/24/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import Foundation
import UIKit

class Movie {
    
    private let movieTitleKey = "title"
    private let ratingKey = "vote_average"
    private let overviewKey = "overview"
    private let posterUrlKey = "poster_path"
    
    
    let movieTitle: String
    let rating: Double
    let overview: String
    var posterPath: UIImage?
    let posterUrlString: String
    
    var image: UIImage?
    
    var posterUrl: URL? {
        return URL(string: posterUrlString)
    }
    
    init?(jsonDictionary: [String:Any]) {
        
        guard let movieTitle = jsonDictionary[movieTitleKey] as? String,
            let rating = jsonDictionary[ratingKey] as? Double,
            let overview = jsonDictionary[overviewKey] as? String,
            let posterUrl = jsonDictionary[posterUrlKey] as? String
        
            else { return nil }
        
        self.movieTitle = movieTitle
        self.rating = rating
        self.overview = overview
        self.posterUrlString = posterUrl
        
    }
}
