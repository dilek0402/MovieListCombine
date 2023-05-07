//
//  MovieListDataController.swift
//  MovieList
//
//  Created by Dilek Eminoğlu on 03.03.2023.
//

import Foundation
import Combine

final class MovieListDataController: MovieListDataProtocol {
    
    // MARK: - Constant Enum
    
    private enum Constant {
        static let path = "3/movie/popular?api_key="
        static let pagingKey = "&page="
    }
    
    private var bag = Set<AnyCancellable>()
    
    // MARK: - Public Methods
    
    func fetchMovies(page: Int,
                     completion: @escaping completion) {
        let urlString = NetworkConfiguration.basePath + Constant.path +
        NetworkConfiguration.apiKey + NetworkConfiguration.language +
        Constant.pagingKey + String(page)
        let url = URL(string: urlString)!
        

        let publisher = URLSession.shared.dataTaskPublisher(for: url)
        
        publisher
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: Movies.self, decoder: JSONDecoder())
            .sink { response in
                switch response {
                case .failure(let error):
                    completion(nil, error)
                default:
                    break
                }
            } receiveValue: { value in
                completion(value, nil)
            }
            .store(in: &bag)
        
    }
    

    
}
