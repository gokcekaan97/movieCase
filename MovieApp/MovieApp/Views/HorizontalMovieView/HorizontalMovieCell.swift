//
//  HorizontalMovieCell.swift
//  MovieApp
//
//  Created by kaan gokcek on 8.11.2023.
//

import UIKit
import SnapKit

class HorizontalMovieCell: UICollectionViewCell {
  public var image: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    viewSetup()
    constraintsSetup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func constraintsSetup() {
    image.snp.makeConstraints { make in
      make.top.leading.equalToSuperview().offset(16)
      make.bottom.trailing.equalToSuperview().inset(16)
    }
  }
  
  func viewSetup() {
    self.addSubview(self.image)
  }
}
