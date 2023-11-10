//
//  ImageView+Extension.swift
//  MovieApp
//
//  Created by kaan gokcek on 10.11.2023.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
  func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
    if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
      self.image = imageFromCache
      return
    }
    contentMode = mode
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard
        let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
        let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
        let data = data, error == nil,
        let image = UIImage(data: data)
      else { return }
      DispatchQueue.main.async() { [weak self] in
        imageCache.setObject(image, forKey: url as AnyObject)
        self?.image = image
      }
    }.resume()
  }
  
  func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
    guard let url = URL(string: link) else { return }
    downloaded(from: url, contentMode: mode)
  }
}
