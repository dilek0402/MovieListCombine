//
//  MovieListTableViewCell.swift
//  MovieList
//
//  Created by Dilek Eminoğlu on 03.03.2023.
//

import UIKit

final class MovieListTableViewCell: UITableViewCell {
    
    // MARK: - Constant
    
    private enum Constant {
        static let borderWidth: CGFloat = 1
        static let verticalPadding: CGFloat = 5
        static let horizontalPadding: CGFloat = 15
        static let padding: CGFloat = 5
        static let imageWidth: CGFloat = 110
        static let imageHeight: CGFloat = 160
    }
    
    // MARK: - Properties
    
    private var movie: Movie? {
        didSet {
            if let movie = movie {
                movieNameLabel.text = movie.title
                airDateLabel.text = movie.releaseDate
                if let average = movie.voteAverage {
                    ratingLabel.text = String(describing: average)
                }
                if let imagePath = movie.posterPath {
                    downloadImage(path: imagePath)
                }
            }
        }
    }

    
    // MARK: - Layout Properties
    
    private var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.shadowColor = Theme.Palette.shadowColor.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 2
        view.backgroundColor = Theme.Palette.backgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor  = UIColor.gray.cgColor
        imageView.layer.borderWidth  = Constant.borderWidth
        imageView.backgroundColor    = Theme.Palette.tertiaryColor
        imageView.layer.cornerRadius = 18.75
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var textContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var movieNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Theme.Palette.labelColor
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    private var airDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Theme.Palette.secondaryLabelColor
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        return label
    }()
    
    private var ratingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Theme.Palette.secondaryLabelColor
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        return label
    }()
    
    // MARK: - Init Methods
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = Theme.Palette.clear
        setupUI()
        setupConstraints()
    }
    
    override func prepareForReuse() {
        ratingLabel.text = nil
        airDateLabel.text = nil
        movieNameLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        self.addSubview(containerView)
        containerView.addSubview(posterImageView)
        containerView.addSubview(textContainerView)
        textContainerView.addSubview(movieNameLabel)
        textContainerView.addSubview(airDateLabel)
        textContainerView.addSubview(ratingLabel)
    }
    
    private func setupConstraints() {
        addConstraints([containerView.topAnchor.constraint(equalTo: topAnchor, constant: Constant.verticalPadding),
                        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constant.verticalPadding),
                        containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.horizontalPadding),
                        containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.horizontalPadding)])
        
        addConstraints([posterImageView.heightAnchor.constraint(equalToConstant: Constant.imageHeight),
                        posterImageView.widthAnchor.constraint(equalToConstant: Constant.imageWidth),
                        posterImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constant.padding),
                        posterImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constant.padding),
                        posterImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Constant.padding)])
        
        addConstraints([textContainerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constant.padding),
                        textContainerView.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: -Constant.padding),
                        textContainerView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: Constant.horizontalPadding),
                        textContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constant.padding)])
        
        addConstraints([movieNameLabel.topAnchor.constraint(equalTo: textContainerView.topAnchor, constant: Constant.padding),
                        movieNameLabel.bottomAnchor.constraint(equalTo: airDateLabel.topAnchor, constant: -Constant.padding),
                        movieNameLabel.leadingAnchor.constraint(equalTo: textContainerView.leadingAnchor, constant: Constant.horizontalPadding),
                        movieNameLabel.trailingAnchor.constraint(equalTo: textContainerView.trailingAnchor, constant: -Constant.padding)])
        addConstraints([airDateLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: Constant.padding),
                        airDateLabel.bottomAnchor.constraint(equalTo: ratingLabel.topAnchor, constant: -Constant.padding),
                        airDateLabel.leadingAnchor.constraint(equalTo: textContainerView.leadingAnchor, constant: Constant.horizontalPadding),
                        airDateLabel.trailingAnchor.constraint(equalTo: textContainerView.trailingAnchor, constant: -Constant.padding)])
        
        addConstraints([ratingLabel.topAnchor.constraint(equalTo: airDateLabel.bottomAnchor, constant: Constant.padding),
                        ratingLabel.leadingAnchor.constraint(equalTo: textContainerView.leadingAnchor, constant: Constant.horizontalPadding),
                        ratingLabel.trailingAnchor.constraint(equalTo: textContainerView.trailingAnchor, constant: -Constant.padding)])
        
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
    
    // MARK: - Public Methods
    
    func configureCell(item: Movie) {
        movie = item
    }
}
