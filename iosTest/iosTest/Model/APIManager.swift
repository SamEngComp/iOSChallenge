//
//  APIManager.swift
//  iosTest
//
//  Created by Nathalia Cardoso on 07/10/21.
//

import Foundation
import Alamofire

class APIManager {
    
    func getAllMovies(completion: @escaping ([Movie]?) -> Void) {
        
    }

    func apiRequisition (url: String) {
        AF.request(url)
            .responseJSON { (response) in
                debugPrint(response)
            }
    }

}
