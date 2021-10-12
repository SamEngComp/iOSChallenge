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
    private let coreDataManager = CoreDataManager()
    private let search = UISearchController(searchResultsController: nil)
    private var movies: [Movie] = []
    private var allMovies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = scene
        scene.controller = self
        scene.favoriteMovies = loadFavorites()

        self.setupNavigation()
        self.fetchMovies(currentPage: 1)
        self.setUpSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableContent()
    }
    
    private func setupNavigation() {
        self.navigationController?.navigationBar.isTranslucent = false
        navigationController?.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        self.title = "Filmes em cartaz"
    }
    
    func showMovieDecription(movie: Movie) {
        let movieDescriptionViewController = MovieDescriptionViewController()
        movieDescriptionViewController.movie = movie
        self.navigationController?.pushViewController(movieDescriptionViewController, animated: false)
    }
    
    func fetchMovies(currentPage: Int) {
        self.apiManager.getMovies(currentPage: currentPage) { result in
            if let result = result {
                self.movies = result.allMovies
                self.scene.setupScene(allMovies: result.allMovies, totalPages: result.total_pages)
                self.allMovies = self.movies
            } else {
                self.scene.notFoundPage()
            }
        }
    }
    
    func markFavorite(isFavorite: Bool, movie: Movie) {
        if isFavorite {
            coreDataManager.createFavoriteMovie(movie: movie)
        } else {
            coreDataManager.remove(id: Int32(movie.id))
        }
    }
    
    func loadFavorites() -> [Movie] {
        var favoriteMovies: [Movie] = []
        coreDataManager.fetchAll().forEach { movie in
            favoriteMovies.append(coreDataManager.parse(favoriteMovie: movie))
        }
        
        return favoriteMovies
    }
    
    func searchFavoriteMovies(name: String) -> [Movie] {
        var moviesResult: [Movie] = []
        movies.forEach { movie in
            if movie.title.contains(name) {
                moviesResult.append(movie)
            }
        }
        return moviesResult
    }

}

extension MovieListViewController: UISearchResultsUpdating {

    private func setUpSearchBar() {
        
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
        
        guard let nomeSearch = searchController.searchBar.text else { return }
        
        if !nomeSearch.isEmpty {
            if search.searchBar.selectedScopeButtonIndex == 1 {
                self.movies = []
                let moviesRequest = coreDataManager.fetchMovieByName(name: nomeSearch)
                moviesRequest.forEach({ movie in
                    self.movies.append(coreDataManager.parse(favoriteMovie: movie))
                })
                scene.setMovies(movies: movies)
                
            } else {
                scene.setMovies(movies: self.searchFavoriteMovies(name: nomeSearch))
            }
        } else {
            self.movies = self.allMovies
            tableContent()
        }
    }
    
    private func tableContent() {
        if search.searchBar.selectedScopeButtonIndex == 1 {
            scene.setMovies(movies: self.loadFavorites())
            scene.paginator(isHidden: true)
        } else {
            scene.setMovies(movies: movies)
            scene.paginator(isHidden: false)
        }
    }
    
}

