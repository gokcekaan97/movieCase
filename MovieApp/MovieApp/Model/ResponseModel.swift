//
//  ResponseModel.swift
//  MovieApp
//
//  Created by kaan gokcek on 8.11.2023.
//

import Foundation

struct SearchResponse: Codable {
  let search: [SearchList]
  let response: String?
  let totalResults: String?
  
  enum CodingKeys: String, CodingKey {
    case search = "Search"
    case response = "Response"
    case totalResults
  }
}

struct SearchList: Codable {
  let title: String?
  let year: String?
  
  enum CodingKeys: String, CodingKey {
    case title = "Title"
    case year = "Year"
  }
}
