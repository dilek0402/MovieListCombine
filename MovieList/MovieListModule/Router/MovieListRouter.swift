//
//  MovieListRouter.swift
//  MovieList
//
//  Created by Dilek Eminoğlu on 03.03.2023.
//

import UIKit

final class MovieListRouter {
    
    // MARK: - Properties
    
    var initialViewController: UIViewController!
    
    //MARK: - Init
    
    init() {
        let controller = MovieListViewController()
        let dataController = MovieListDataController()
        let viewModel = MovieListViewModel(dataController: dataController,
                                           router: self)
        controller.viewModel = viewModel
        initialViewController = controller
    }
}

extension MovieListRouter {
    
    func proceedToMovieDetailViewController(movie: Movie) {
        let controller = MovieDetailViewController()
        let dataController = MovieListDataController()
        let viewModel = MovieDetailViewModel(dataController: dataController,
                                             router: self)
        viewModel.item = movie
        controller.viewModel = viewModel
        initialViewController.navigationController?.pushViewController(controller,
                                                                       animated: true)
    }
}
