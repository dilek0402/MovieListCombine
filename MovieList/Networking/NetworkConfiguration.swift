//
//  NetworkConfiguration.swift
//  MovieList
//
//  Created by Dilek Eminoğlu on 03.03.2023.
//

struct NetworkConfiguration {
    
    // MARK: - Properties
    
    static var basePath: String {
        return "https://api.themoviedb.org/"
    }
    
    static  var apiKey: String {
        return "16b57169954864f01854a6d42dbd2234"
    }
    
    static  var language: String {
        return "&language=en-US"
    }
    
    static  var imagePath: String {
        return "https://image.tmdb.org/t/p/w500"
    }
    
}
