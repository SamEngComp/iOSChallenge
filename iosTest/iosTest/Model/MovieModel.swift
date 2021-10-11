//
//  MovieModel.swift
//  iosTest
//
//  Created by Nathalia Cardoso on 08/10/21.
//

import Foundation

struct Movie: Decodable {
    //let adult: Bool
    //let backdrop_path: String
    //let genre_ids: [Int]
    //let id: Int
    //let original_language: String
    //let original_title: String
    let overview: String
    //let popularity: Double
    let poster_path: String
    //let release_date: String
    let title: String
    //let video: Bool
    //let vote_average: Float
    //let vote_count: Int
    
    enum CodingKeys: String, CodingKey {
        //case adult
        //case backdrop_path
        //case genre_ids
        //case id
        //case original_language
        //case original_title
        case overview
        //case popularity
        case poster_path
        //case release_date
        case title
        //case video
        //case vote_average
        //case vote_count
    }
}

struct Movies: Decodable {
    let dates: [String : String]
    let page: Int
    let allMovies: [Movie]
    let total_pages: Int
    let total_results: Int
    
    enum CodingKeys: String, CodingKey {
        case dates
        case page
        case allMovies = "results"
        case total_pages
        case total_results
    }
}
