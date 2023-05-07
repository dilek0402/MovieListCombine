//
//  MoviesDataModel.swift
//  MovieList
//
//  Created by Dilek Eminoğlu on 03.03.2023.
//

// MARK: - Movies Model

struct Movies: Codable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
    }
}

// MARK: - Movie Model

struct Movie: Codable {
    let backDropPath: String?
    let posterPath: String?
    let title: String?
    let id: Int?
    let overview: String?
    let popularity: Double?
    let voteAverage: Double?
    let voteCount: Int?
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case backDropPath = "backdrop_path"
        case posterPath = "poster_path"
        case title = "title"
        case id
        case overview
        case popularity
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case releaseDate = "release_date"
    }
}
