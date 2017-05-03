//
//  MovieListTableViewController.swift
//  MovieSearchChallenge
//
//  Created by Nick Reichard on 2/24/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    // MARK: - Properties
    
    var movies: [Movie] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        movieSearchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        guard let searchTerm = searchBar.text else { return }
        
        MovieController.fetchMovie(for: searchTerm) { (newMovie) in
            DispatchQueue.main.async {
                self.movies = newMovie
            }
        }
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movies.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        
        let movie = movies[indexPath.row]
        
        cell.movie = movie
        
        return cell
    }
    
    // MARK: - Navigation
    
    // Put the image into a favorite UIView
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
