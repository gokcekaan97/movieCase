//
//  HorizontalMovieCell.swift
//  MovieApp
//
//  Created by kaan gokcek on 7.11.2023.
//

import UIKit
import SnapKit

class HorizontalMovieCell: UITableViewCell {
  public let image = UIImageView()
  
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
      make.trailing.bottom.equalToSuperview().inset(16)
    }
  }
  
  func viewSetup() {
    self.addSubview(self.image)
  }
}
