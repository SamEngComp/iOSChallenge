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
        label.textColor = .black
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
        button.isEnabled = true
        return button
    }()
    
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
        print("marked as favorite")
    }
}
