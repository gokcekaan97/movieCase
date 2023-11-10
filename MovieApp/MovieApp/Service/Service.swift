//
//  Service.swift
//  MovieApp
//
//  Created by kaan gokcek on 8.11.2023.
//

import Foundation

final class ApiService {
  static let shared = ApiService()
  
  private init() {
    
  }
  
  enum ApiServiceError: Error {
    case noData
    case urlNil
    case decodeError
  }
  
  public func execute<T: Codable>(
    _ request: ApiRequest,
    expecting type: T.Type,
    completion: @escaping (Result<T,Error>) -> Void
  ){
    guard let url = request.url else { return completion(.failure(ApiServiceError.urlNil)) }
    URLSession.shared.dataTask(with: url){ data, response, error in
      guard let data = data, error == nil else {
        return completion(.failure(ApiServiceError.noData))
      }
      guard let requestBody = try? JSONDecoder().decode(T.self, from: data) else {
        return completion(.failure(ApiServiceError.decodeError))
      }
      completion(.success(requestBody))
      return
    }.resume()
  }
}
