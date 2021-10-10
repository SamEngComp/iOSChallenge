//
//  ViewController.swift
//  iosTest
//
//  Created by Nathalia Cardoso on 05/10/21.
//

import UIKit
import Alamofire

class MovieListViewController: UIViewController, UISearchResultsUpdating {
    
    let manager = APIManager()
    let scene = MovieListScene()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = scene
        scene.controller = self
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        self.title = "Filmes em cartaz"
        
        setUpSearchBar()
        //manager.apiRequisition(url: "https://api.themoviedb.org/3/movie/now_playing?api_key=c2e78b4a8c14e65dd6e27504e6df95ad&language=pt-BR")
    }
    
    func setUpSearchBar() {
        let search = UISearchController(searchResultsController: nil)
        //UISearchBar.appearance().tintColor = UIColor.init(named: "actionColor")
        search.searchBar.placeholder = "Pesquisar"
        search.searchBar.setValue("Cancelar", forKey: "cancelButtonText")
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.scopeButtonTitles = ["Todos", "Favoritos"]
        search.searchBar.showsScopeBar = true
        self.navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        print()
    }
    
    func showMovieDecription(movie: Movie) {
        let movieDescriptionViewController = MovieDescriptionViewController()
        movieDescriptionViewController.movie = movie
        self.navigationController?.pushViewController(movieDescriptionViewController, animated: true)
    }

}

