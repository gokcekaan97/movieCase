//
//  MovieUseCase.swift
//  MovieApp
//
//  Created by kaan gokcek on 8.11.2023.
//

import Foundation

protocol MovieUseCaseType {
  func getMovieList(
    search: String,
    page: String?,
    completion: @escaping (Result<SearchResponse,Error>) -> Void
  )
  
  func getMovieDetail(
    id: String,
    completion: @escaping (Result<MovieDetail,Error>) -> Void
  )
}

struct MovieUseCase: MovieUseCaseType {
  func getMovieDetail(id: String, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
    var queryParameters = [URLQueryItem]()
    queryParameters.append(URLQueryItem(name: "i", value: id))
    let request = ApiRequest(queryParameters: queryParameters)
    ApiService.shared.execute(request, expecting: MovieDetail.self) { result in
      switch result{
      case .success(let movie):
        completion(.success(movie))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  func getMovieList(
    search: String,
    page: String?,
    completion: @escaping (Result<SearchResponse,Error>) -> Void
  ) {
    var queryParameters = [URLQueryItem]()
    queryParameters.append(URLQueryItem(name: "s", value: search))
    if let page = page {
      queryParameters.append(URLQueryItem(name: "page", value: page))
    }
    let request = ApiRequest(
      queryParameters: queryParameters
    )
    ApiService.shared.execute(request, expecting: SearchResponse.self) { result in
      switch result{
      case .success(let movies):
        completion(.success(movies))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}
