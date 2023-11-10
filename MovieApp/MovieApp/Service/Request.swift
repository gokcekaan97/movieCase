//
//  Request.swift
//  MovieApp
//
//  Created by kaan gokcek on 8.11.2023.
//

import Foundation

final class ApiRequest {
  private struct Constants {
    static let baseUrl = "https://www.omdbapi.com"
  }
  private let queryParameters: [URLQueryItem]
  private var urlString: String{
    var string = Constants.baseUrl
    string += "/?"
    string += "apikey=1532428"
    if !queryParameters.isEmpty{
      string += "&"
      let parameters = queryParameters.compactMap({
        guard let value = $0.value else { return nil }
        return "\($0.name)=\(value)"
      }).joined(separator: "&")
      string += parameters
    }
    return string
  }
  public var url: URL?{
    return URL(string: urlString)
  }
  
  public init(queryParameters: [URLQueryItem] = []) {
    self.queryParameters = queryParameters
  }
}
