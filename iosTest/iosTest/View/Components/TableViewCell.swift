//
//  TableViewCell.swift
//  iosTest
//
//  Created by Nathalia Cardoso on 07/10/21.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell {

    let movieNameLabel: UILabel = {
        let label = UILabel()
        label.text = "empty"
        label.textColor = .label
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let movieImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.addTarget(self, action: #selector(markingAsFavorite), for: .touchUpInside)
        return button
    }()
    
    private var isFavorite = false
    
    var movie: Movie?
    
    var controller: MovieListViewController?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(movieImage)
        self.contentView.addSubview(movieNameLabel)
        self.contentView.addSubview(favoriteButton)
        
        self.selectionStyle = .none
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fillFavoriteButton() {
        self.favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        self.isFavorite = true
    }
    
    func unfillFavoriteButton() {
        self.favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        self.isFavorite = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        movieImage.frame = CGRect(x: 5, y: 5, width: 100, height: contentView.frame.size.height - 10)
        movieNameLabel.frame = CGRect(x: movieImage.frame.size.width + 10, y: 0, width: contentView.frame.size.width/2 , height: contentView.frame.size.height)
        
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 3),
            favoriteButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -15),
            favoriteButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -3)
        ])
    }
    
    @objc func markingAsFavorite() {
        guard let movie = self.movie else { return }
        if isFavorite {
            self.unfillFavoriteButton()
            self.controller?.markFavorite(isFavorite: isFavorite, movie: movie)
            
        } else {
            self.fillFavoriteButton()
            self.controller?.markFavorite(isFavorite: isFavorite, movie: movie)
        }
    }
}
