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
    let coreDataManager = CoreDataManager()
    
    var isFavorite = false
    
    
    override func viewDidLoad() {
        self.view = scene
        
        self.setupScene()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(markAsFavorite))
        if let movie = self.movie {
            if coreDataManager.fetchID(id: Int32(movie.id)) != nil {
                self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star.fill")
                isFavorite = true
            }
        }
    }
    
    func setupScene() {
        guard let movie = movie else {return}
        scene.setTitleLabel(title: movie.title)
        if let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path)") {
            scene.setMovieImage(url: url)
        }
        scene.setMovieDescriptionText(descriptionText: movie.overview)
        
    }
    
    @objc func markAsFavorite() {
        if isFavorite {
            self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star")
            if let movie = self.movie {
                coreDataManager.remove(id: Int32(movie.id))
            }
            isFavorite = false
        } else {
            self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star.fill")
            if let movie = self.movie {
                coreDataManager.createFavoriteMovie(movie: movie)
            }
            isFavorite = true
        }
    }
}
