//
//  VerticalMovieCell.swift
//  MovieApp
//
//  Created by kaan gokcek on 7.11.2023.
//

import UIKit
import SnapKit

class VerticalMovieCell: UITableViewCell {
  public let image = UIImageView() 
  public let cellName = UILabel()
  public let cellDescription = UILabel()
  
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
      make.leading.bottom.top.equalToSuperview().offset(16)
    }
    cellName.snp.makeConstraints { make in
      make.leading.equalTo(image.snp.trailing).offset(16)
      make.top.equalToSuperview().offset(16)
      make.trailing.equalToSuperview().inset(16)
    }
    cellDescription.snp.makeConstraints { make in
      make.leading.equalTo(image.snp.trailing).offset(16)
      make.top.equalTo(cellName.snp.bottom).offset(16)
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
