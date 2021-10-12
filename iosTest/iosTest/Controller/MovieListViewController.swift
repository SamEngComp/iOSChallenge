//
//  ViewController.swift
//  iosTest
//
//  Created by Nathalia Cardoso on 05/10/21.
//

import UIKit
import CoreData

class MovieListViewController: UIViewController {
    
    private let apiManager = APIManager()
    private let scene = MovieListScene()
    let coreDataManager = CoreDataManager()
    let search = UISearchController(searchResultsController: nil)
    private var movies: [MovieModelParse] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = scene
        scene.controller = self

        self.setupNavigation()
        self.fetchMovies(currentPage: 1)
        self.setUpSearchBar()
    }
    
    func setupNavigation() {
        self.navigationController?.navigationBar.isTranslucent = false
        navigationController?.view.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        self.title = "Filmes em cartaz"
    }
    
    func showMovieDecription(movie: MovieModelParse) {
        let movieDescriptionViewController = MovieDescriptionViewController()
        movieDescriptionViewController.movie = movie
        self.navigationController?.pushViewController(movieDescriptionViewController, animated: false)
    }
    
    func fetchMovies(currentPage: Int) {
        self.apiManager.getMovies(currentPage: currentPage) { result in
            if let result = result {
                result.allMovies.forEach({ movie in
                    self.movies.append(self.apiManager.parse(movie: movie))
                })
                self.scene.setupScene(allMovies: self.movies, totalPages: result.total_pages)
            } else {
                self.scene.notFoundPage()
            }
        }
    }

}

extension MovieListViewController: UISearchResultsUpdating {

    func setUpSearchBar() {
        
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
//        if search.searchBar.selectedScopeButtonIndex == 1 {
//            scene.setMovies(movies: <#T##[Movie]#>)  coreDataManager.fetchAll()
//        } else {
//
//        }
        
    }
    
}

