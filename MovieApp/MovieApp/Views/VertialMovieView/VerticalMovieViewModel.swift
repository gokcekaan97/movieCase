//
//  VerticalMovieViewModel.swift
//  MovieApp
//
//  Created by kaan gokcek on 10.11.2023.
//

import Foundation

class VerticalMovieViewModel {
  var response: SearchResponse?
  let movieListUseCase = MovieUseCase()
  init() {
  }
  
  func getFirstList() {
    movieListUseCase.getMovieList(search: "Star", page: nil) { result in
      switch result {
      case .success(let movies):
        self.response = movies
      case .failure(let error):
        print(error)
      }
    }
  }
}
