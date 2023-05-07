//
//  MovieDetailViewModel.swift
//  MovieList
//
//  Created by Dilek Eminoğlu on 03.03.2023.
//

final class MovieDetailViewModel {
    
    // MARK: - Private Properties
    
    private var dataController:MovieListDataController
    private var router: MovieListRouter
    
    var item: Movie?
    
    // MARK: - Init
    
    init(dataController: MovieListDataController,
         router: MovieListRouter) {
        self.dataController = dataController
        self.router = router
    }
}
