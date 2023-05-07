//
//  MovieListDataProtocol.swift
//  MovieList
//
//  Created by Dilek Eminoğlu on 03.03.2023.
//

protocol MovieListDataProtocol {
    
    typealias completion = (Movies?, Error?) -> Void
    
    func fetchMovies(page: Int,
                     completion: @escaping completion)
    
}
