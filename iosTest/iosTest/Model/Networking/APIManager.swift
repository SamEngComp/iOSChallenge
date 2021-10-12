//
//  APIManager.swift
//  iosTest
//
//  Created by Nathalia Cardoso on 07/10/21.
//

import Foundation
import Alamofire

class APIManager {
    
    func getMovies(currentPage: Int, completion: @escaping (Movies?) -> Void) {
        AF.request("https://api.themoviedb.org/3/movie/now_playing?api_key=c2e78b4a8c14e65dd6e27504e6df95ad&language=pt-BR&page=\(currentPage)").validate().responseDecodable(of: Movies.self) { (response) in
            
            guard let movies = response.value else {
                completion(nil)
                return
            }
            completion(movies)
            
        }
    }

}
