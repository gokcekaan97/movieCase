//
//  HorizontalMovieViewModel.swift
//  MovieApp
//
//  Created by kaan gokcek on 10.11.2023.
//

import Foundation

class HorizontalMovieViewModel {
  var responseList = [SearchList]()
  let movieListUseCase = MovieUseCase()
  var pageInt = 1
  let initialSearchString = "Comedy"
  var pageString: String? = nil
  
  init() {
  }
  
  func getFirstList(_ search: String? = nil) {
    pageInt = 1
    movieListUseCase.getMovieList(search: search ?? initialSearchString, page: pageString) { result in
      switch result {
      case .success(let movies):
        self.responseList.append(contentsOf: movies.search)
        self.pageInt += 1
      case .failure(let error):
        print(error)
      }
    }
  }
  
  func getListWithPage(_ search: String? = nil) {
    if pageInt != 1 {
      pageString = String(pageInt)
      movieListUseCase.getMovieList(search: search ?? initialSearchString, page: pageString) { result in
        switch result {
        case .success(let movies):
          self.responseList.append(contentsOf: movies.search)
          self.pageInt += 1
        case .failure(let error):
          print(error)
        }
      }
    }
  }
}
