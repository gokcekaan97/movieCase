//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by kaan gokcek on 11.11.2023.
//

import Foundation

class MovieDetailViewModel {
  let movieListUseCase = MovieUseCase()
  var movieId: String?
  var movieDetail: MovieDetail?

  init(movieId: String) {
    self.movieId = movieId
  }
  
  func getMovieDetail(){
    movieListUseCase.getMovieDetail(id: movieId!) { result in
      switch result {
      case .success(let movie):
        self.movieDetail = movie
      case .failure(let error):
        print(error)
      }
    }
  }
}
