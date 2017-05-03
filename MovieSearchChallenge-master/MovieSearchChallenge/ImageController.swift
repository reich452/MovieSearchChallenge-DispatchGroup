//
//  ImageController.swift
//  MovieSearchChallenge
//
//  Created by Nick Reichard on 2/24/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import Foundation
import UIKit

class ImageController {
    
    static let baseUrlString = "https://image.tmdb.org/t/p/w500/"
    
    static func image(forURL url: String, completion: @escaping (UIImage?) -> Void) {
        
        guard let url = URL(string: "\(baseUrlString)\(url)") else {
            fatalError("Image URL optional is nil")
        }
        
        NetworkController.performRequest(for: url, httpMethod: .Get) { (data, error) in
            guard let data = data,
                let image = UIImage(data: data) else {
                    
                    DispatchQueue.main.async { completion(nil) }
                    return
            }
            DispatchQueue.main.async { completion(image) }
            
        }
    }
}
