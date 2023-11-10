//
//  HorizontalMovieViewModel.swift
//  MovieApp
//
//  Created by kaan gokcek on 10.11.2023.
//

import Foundation

class HorizontalMovieViewModel {
  var response: SearchResponse?
  let movieListUseCase = MovieUseCase()
  init() {
  }
  
  func getFirstList() {
    movieListUseCase.getMovieList(search: "Comedy", page: nil) { result in
      switch result {
      case .success(let movies):
        self.response = movies
      case .failure(let error):
        print(error)
      }
    }
  }
}
