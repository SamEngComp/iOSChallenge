//
//  MovieDescription.swift
//  iosTest
//
//  Created by Nathalia Cardoso on 09/10/21.
//

import UIKit

class MovieDescriptinScene: UIView {
    
    private let movieImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let movieDescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .label
        textView.isEditable = false
        textView.font = UIFont.boldSystemFont(ofSize: 14)
        textView.textAlignment = .justified
        return textView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        
        addSubview(titleLabel)
        addSubview(movieImage)
        addSubview(movieDescriptionTextView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitleLabel(title: String?) {
        self.titleLabel.text = title
    }
    
    func setMovieImage(url: URL) {
        self.movieImage.load(url: url)
    }
    
    func setMovieDescriptionText(descriptionText: String?) {
        self.movieDescriptionTextView.text = descriptionText
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupTitleLabel()
        setupMovieImage()
        setupMovieDescriptionTextView()
    }
    
    func setupMovieImage() {
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 15),
            movieImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            movieImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            movieImage.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: 50)
        ])
    }
    
    func setupMovieDescriptionTextView() {
        movieDescriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            movieDescriptionTextView.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 20),
            movieDescriptionTextView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            movieDescriptionTextView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            movieDescriptionTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
    }
    
    func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
}
