//
//  FilmListScene.swift
//  iosTest
//
//  Created by Nathalia Cardoso on 07/10/21.
//

import Foundation
import UIKit

class MovieListScene: UIView {
    
    var controller: MovieListViewController?
    private var movies: [MovieModelParse] = [] {
        didSet {
            self.paginatorLabel.text = "Página \(currentPage)"
            tableView.reloadData()
        }
    }
    private let tableView = UITableView()
    private var currentPage = 1
    private var totalPages = 1
    
    let paginatorLabel: UILabel = {
        let label = UILabel()
        label.text = "Página 1"
        label.textColor = .black
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        return label
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
         button.setTitleColor(.systemBlue, for: .normal)
         button.setTitle("próxima >", for: .normal)
         button.addTarget(self, action: #selector(goToNextPage), for: .touchUpInside)
         return button
    }()
    
    let previousButton: UIButton = {
        let button = UIButton()
         button.setTitleColor(.systemBlue, for: .normal)
         button.setTitle("< anterior", for: .normal)
         button.isHidden = true
         button.addTarget(self, action: #selector(goToPreviousPage), for: .touchUpInside)
         return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemGray6
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        setupTableView()
        setupPaginatorLabel()
        setupNextButton()
        setupPreviousButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupScene(allMovies: [MovieModelParse], totalPages: Int) {
        self.movies = allMovies
        self.totalPages = totalPages
    }
    
    func notFoundPage() {
        self.movies = []
        self.paginatorLabel.text = "Página \(currentPage)\nnão encontrada"
    }
    
    func setMovies(movies: [MovieModelParse]) {
        self.movies = movies
    }
    
    private func setupTableView() {
        addSubview(tableView)
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cellId")
        
        tableView.isScrollEnabled = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -80)
        ])
        
    }
    
    func setupPaginatorLabel() {
        addSubview(paginatorLabel)
        paginatorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            paginatorLabel.topAnchor.constraint(equalTo: self.tableView.bottomAnchor, constant: 4),
            paginatorLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            paginatorLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
    }
    
    func setupNextButton() {
        addSubview(nextButton)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: self.tableView.bottomAnchor, constant: 4),
            nextButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            nextButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
    }
    
    func setupPreviousButton() {
        addSubview(previousButton)
        
        previousButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            previousButton.topAnchor.constraint(equalTo: self.tableView.bottomAnchor, constant: 4),
            previousButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            previousButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
    }
    
    @objc func goToNextPage() {
        if currentPage < totalPages {
            currentPage += 1
            if currentPage == 2 {
                previousButton.isHidden = false
            }
            if currentPage == totalPages {
                nextButton.isHidden = true
            }
            self.controller?.fetchMovies(currentPage: self.currentPage)
        }
        
    }
    
    @objc func goToPreviousPage() {
        if (currentPage > 1) && (currentPage <= totalPages) {
            currentPage -= 1
            if currentPage == 1 {
                previousButton.isHidden = true
            }
            if currentPage == totalPages-1 {
                nextButton.isHidden = false
            }
            self.controller?.fetchMovies(currentPage: self.currentPage)
            
        }
    }
    
}

extension MovieListScene: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! TableViewCell
        cell.movieNameLabel.text = movies[indexPath.row].title
//        if let url = URL(string: "https://image.tmdb.org/t/p/w500\(movies[indexPath.row].poster_path)") {
//            cell.movieImage.load(url: url) // failed to log metrics
//        }
        cell.movieImage.image = UIImage(data: movies[indexPath.row].poster_img)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        controller?.showMovieDecription(movie: self.movies[indexPath.row])
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
