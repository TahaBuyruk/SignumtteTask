//
//  SearchResponse.swift
//  Signum Movie
//
//  Created by Taha Eren Buyruk on 10.02.2021.
//

import Foundation

class SearchResponse: Codable {
  let movie: [Movie]
  let totalResults, response: String
  
  enum CodingKeys: String, CodingKey {
    case movie = "Search"
    case totalResults
    case response = "Response"
  }
  
  init(movie: [Movie], totalResults: String, response: String) {
    self.movie = movie
    self.totalResults = totalResults
    self.response = response
  }
}

// MARK: - Search
class Movie: Codable {
  let title, year, imdbId, type: String
  let poster: String
  
  enum CodingKeys: String, CodingKey {
    case title = "Title"
    case year = "Year"
    case imdbId = "imdbID"
    case type = "Type"
    case poster = "Poster"
  }
  
  init(title: String, year: String, imdbId: String, type: String, poster: String) {
    self.title = title
    self.year = year
    self.imdbId = imdbId
    self.type = type
    self.poster = poster
  }
}
