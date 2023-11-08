//
//  VerticalMovieCell.swift
//  MovieApp
//
//  Created by kaan gokcek on 7.11.2023.
//

import UIKit
import SnapKit

class VerticalMovieCell: UITableViewCell {
  public var image: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }()
  public var cellName = UILabel()
  public var cellDescription = UILabel()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    viewSetup()
    constraintsSetup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func constraintsSetup() {
    image.snp.makeConstraints { make in
      make.leading.top.equalToSuperview().offset(16)
      make.bottom.equalToSuperview().inset(16)
      make.width.equalTo(image.snp.height)
    }
    cellName.snp.makeConstraints { make in
      make.leading.equalTo(image.snp.trailing).offset(16)
      make.top.equalToSuperview().offset(16)
      make.trailing.equalToSuperview().inset(16)
      make.bottom.equalTo(cellDescription.snp.top)
    }
    cellDescription.snp.makeConstraints { make in
      make.leading.equalTo(image.snp.trailing).offset(16)
      make.trailing.equalToSuperview().inset(16)
      make.bottom.equalToSuperview().inset(16)
    }
  }
  
  func viewSetup() {
    self.addSubview(self.image)
    self.addSubview(self.cellName)
    self.addSubview(self.cellDescription)
  }
}
