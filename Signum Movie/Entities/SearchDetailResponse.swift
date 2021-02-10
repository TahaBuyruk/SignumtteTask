//
//  SearchDetailResponse.swift
//  Signum Movie
//
//  Created by Taha Eren Buyruk on 10.02.2021.
//

import Foundation

class SearchDetailResponse: Codable {
  let title, year, rated, released: String
  let runtime, genre, director, writer: String
  let actors, plot, language, country: String
  let awards: String
  let poster: String
  let ratings: [Rating]
  let metascore, imdbRating, imdbVotes, imdbId: String
  let type, dvd, boxOffice, production: String
  let website, response: String
  
  enum CodingKeys: String, CodingKey {
    case title = "Title"
    case year = "Year"
    case rated = "Rated"
    case released = "Released"
    case runtime = "Runtime"
    case genre = "Genre"
    case director = "Director"
    case writer = "Writer"
    case actors = "Actors"
    case plot = "Plot"
    case language = "Language"
    case country = "Country"
    case awards = "Awards"
    case poster = "Poster"
    case ratings = "Ratings"
    case metascore = "Metascore"
    case imdbRating, imdbVotes
    case imdbId = "imdbID"
    case type = "Type"
    case dvd = "DVD"
    case boxOffice = "BoxOffice"
    case production = "Production"
    case website = "Website"
    case response = "Response"
  }
  
  init(title: String, year: String, rated: String, released: String, runtime: String, genre: String, director: String, writer: String, actors: String, plot: String, language: String, country: String, awards: String, poster: String, ratings: [Rating], metascore: String, imdbRating: String, imdbVotes: String, imdbId: String, type: String, dvd: String, boxOffice: String, production: String, website: String, response: String) {
    self.title = title
    self.year = year
    self.rated = rated
    self.released = released
    self.runtime = runtime
    self.genre = genre
    self.director = director
    self.writer = writer
    self.actors = actors
    self.plot = plot
    self.language = language
    self.country = country
    self.awards = awards
    self.poster = poster
    self.ratings = ratings
    self.metascore = metascore
    self.imdbRating = imdbRating
    self.imdbVotes = imdbVotes
    self.imdbId = imdbId
    self.type = type
    self.dvd = dvd
    self.boxOffice = boxOffice
    self.production = production
    self.website = website
    self.response = response
  }
}

class Rating: Codable {
  let source, value: String
  
  enum CodingKeys: String, CodingKey {
    case source = "Source"
    case value = "Value"
  }
  
  init(source: String, value: String) {
    self.source = source
    self.value = value
  }
}
