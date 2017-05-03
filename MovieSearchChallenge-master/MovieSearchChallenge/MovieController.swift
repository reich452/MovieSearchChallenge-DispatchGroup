//
//  MovieController.swift
//  MovieSearchChallenge
//
//  Created by Nick Reichard on 2/24/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import Foundation
import UIKit

class MovieController {
    
    static let baseURL = URL(string: "https://api.themoviedb.org/3/search/movie?")
    static let apiKey = "3e6fc78d34ea9b6595d61441a091daf9"
    
    static func fetchMovie(for movieSearch: String, completion: @escaping ([Movie]) -> Void) {
        
        guard let baseURL = baseURL else { completion([]); return }
        
        let urlParameters = ["query": movieSearch, "api_key": apiKey]
        
        NetworkController.performRequest(for: baseURL, httpMethod: .Get, urlParameters: urlParameters, body: nil) { (data, error) in
            
            if let error = error {
                print(error.localizedDescription)
                completion([])
                return
            }
            
            guard let data = data,
                let jsonDictionaries = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String:Any] else { completion([]); return }
            
            guard let movieArray = jsonDictionaries["results"] as? [[String: Any]] else { completion([]); return }
            
            let movies = movieArray.flatMap( {Movie(jsonDictionary: $0)})
            
            let group = DispatchGroup()
            
            for movie in movies {
                group.enter()
                ImageController.image(forURL: movie.posterUrlString, completion: { (newPoster) in
                    movie.image = newPoster
                    group.leave()
                })
            }
            group.notify(queue: DispatchQueue.main, execute: {
                completion(movies)
            })
        }
    }
}
