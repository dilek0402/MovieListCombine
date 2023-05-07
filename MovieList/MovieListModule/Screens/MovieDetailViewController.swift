//
//  MovieDetailViewController.swift
//  MovieList
//
//  Created by Dilek Eminoğlu on 03.03.2023.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    
    // MARK: - Constant
    
    private enum Constant {
        static let borderWidth: CGFloat = 1
        static let verticalMargin: CGFloat = 30
        static let imageSize: CGFloat = 300
        static let horizontalMargin: CGFloat = 30
    }
    
    // MARK: - Properties
    
    var viewModel: MovieDetailViewModel!
    
    // MARK: - Layout Properties
    
    private var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Theme.Palette.backgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var containerStackView: UIStackView =  {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor  = UIColor.gray.cgColor
        imageView.layer.borderWidth  = Constant.borderWidth
        imageView.layer.cornerRadius = 18.75
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Theme.Palette.labelColor
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private var overviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Theme.Palette.secondaryLabelColor
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        applyStyling()
        setupConstraints()
        updateViev()
    }
    
    // MARK: - Private  Methods
    
    private func setupUI() {
        self.view.addSubview(containerView)
        containerView.addSubview(posterImageView)
        containerView.addSubview(containerStackView)
        containerStackView.addArrangedSubview(nameLabel)
        containerStackView.addArrangedSubview(overviewLabel)
    }
    
    private func applyStyling() {
        self.view.backgroundColor = Theme.Palette.backgroundColor
        self.title = viewModel.item?.title
    }
    
    private func setupConstraints() {
        self.view.addConstraints([containerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                                  containerView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                                  containerView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
                                  containerView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)])
        
        
        self.view.addConstraints([posterImageView.topAnchor.constraint(equalTo: containerView.topAnchor,
                                                                       constant: Constant.verticalMargin),
                                  posterImageView.bottomAnchor.constraint(equalTo: containerStackView.topAnchor,
                                                                          constant: -Constant.verticalMargin),
                                  posterImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                                  posterImageView.widthAnchor.constraint(equalToConstant: Constant.imageSize),
                                  posterImageView.heightAnchor.constraint(equalToConstant: Constant.imageSize)])
        
        self.view.addConstraints([containerStackView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor),
                                  containerStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,
                                                                              constant: Constant.horizontalMargin),
                                  containerStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,
                                                                               constant: -Constant.horizontalMargin)])
        
    }
    
    private func updateViev() {
        if let movie = viewModel.item {
            nameLabel.text = movie.title
            overviewLabel.text = movie.overview
            if let path = movie.posterPath {
                downloadImage(path: path)
            }
        }
    }
    
    private func downloadImage(path: String) {
        let urlString = NetworkConfiguration.imagePath + path
        guard let imageUrl = URL(string: urlString) else {
            return
        }
        ImageCache.publicCache.load(url: imageUrl as NSURL) { image in
            if let image = image {
                DispatchQueue.main.async {
                    self.posterImageView.image = image
                }
            }
        }
    }
}
