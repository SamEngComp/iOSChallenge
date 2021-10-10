//
//  MovieDescriptionViewController.swift
//  iosTest
//
//  Created by Nathalia Cardoso on 09/10/21.
//

import UIKit

class MovieDescriptionViewController: UIViewController {
    
    var movie: Movie?
    
    let scene = MovieDescriptinScene()
    override func viewDidLoad() {
        self.view = scene
        scene.navigationRef = self.navigationController?.navigationBar.bottomAnchor
        scene.titleLabel.text = movie?.title
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie!.poster_path)")!
        scene.movieImage.load(url: url)
        scene.movieDescriptionTextView.text = movie?.overview
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: nil)
    }
}
