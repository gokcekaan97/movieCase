//
//  ViewController.swift
//  MovieApp
//
//  Created by kaan gokcek on 7.11.2023.
//

import UIKit

class MovieViewController: UIViewController {
  public var viewModel = MovieViewModel()
  public var verticalTableView = VerticalMovieView()
  public var horizontalCollectionView = HorizontalMovieView()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupSubviews()
    setupConstraints()
  }

  func setupSubviews() {
    self.view.addSubview(verticalTableView)
    self.view.addSubview(horizontalCollectionView)
  }
  
  func setupConstraints() {
    verticalTableView.snp.makeConstraints { make in
      make.leading.top.trailing.equalToSuperview()
      make.bottom.equalTo(horizontalCollectionView.snp.top)
    }
    horizontalCollectionView.snp.makeConstraints { make in
      make.leading.bottom.trailing.equalToSuperview()
      make.height.equalTo(UIScreen.main.bounds.height/4)
    }
  }
}
