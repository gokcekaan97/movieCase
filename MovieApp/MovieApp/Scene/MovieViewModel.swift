//
//  MovieViewModel.swift
//  MovieApp
//
//  Created by kaan gokcek on 8.11.2023.
//

import Foundation

class MovieViewModel {
  let movieListUseCase = MovieUseCase()
  init() {
    getFirstList()
  }
  func getFirstList() {
      movieListUseCase.getMovieList(search: "star", page: nil) { result in
        switch result {
        case .success(let movies):
          print(movies)
        case .failure(let error):
          print(error)
        }
      }
    }
}
