//
//  MovieListViewModel.swift
//  MovieList
//
//  Created by Dilek Eminoğlu on 03.03.2023.
//

import Foundation
import Combine

final class MovieListViewModel {
    
    // MARK: - Private Properties
    
    private var dataController:MovieListDataController
    private var router: MovieListRouter
    
    
    // MARK: - Public Properties
    
    weak var delegate: MovieListViewModelDelegate?
    
    var items: [Movie] = []
    
    var newItems = CurrentValueSubject<[Movie], Never>([])
    var showLoading = CurrentValueSubject<Bool, Never>(false)
    
    var numberOfServices: Int {
        newItems.value.count
    }
    
    var totalPage: Int = 1
        
    // MARK: - Init
    
    init(dataController: MovieListDataController,
         router: MovieListRouter) {
        self.dataController = dataController
        self.router = router
    }
    
    
    // MARK: - Public Methods
    
    func fetchMovie(page: Int) {
        showLoading.send(true)
        dataController.fetchMovies(page: page) { [weak self] resultModel, error in
            if error != nil {
                return
            }
            guard let model = resultModel else {
                return
            }
            self?.showLoading.send(false)
            self?.totalPage = model.totalPages
            self?.items.append(contentsOf: model.results)
            self?.newItems.send(self?.items ?? [])
        }
    }
    
    func selectMovieItem(index: Int) {
        let item = items[index]
        proceedToMovieDetailViewController(movie: item)
    }
    
    // MARK: - Private Methods
    
    private func proceedToMovieDetailViewController(movie: Movie) {
        router.proceedToMovieDetailViewController(movie: movie)
    }
}

// MARK: - Delegate

protocol MovieListViewModelDelegate: NSObject {
    func moviesLoaded()
    func loadingActive(state: Bool)
}
