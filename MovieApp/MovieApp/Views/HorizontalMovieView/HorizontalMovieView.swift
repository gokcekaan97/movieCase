//
//  HorizontalMovieView.swift
//  MovieApp
//
//  Created by kaan gokcek on 10.11.2023.
//

import UIKit
import SnapKit

class HorizontalMovieView: UIView {
  public var horizontalCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let width = UIScreen.main.bounds.width/2
    layout.itemSize = CGSize(width: width, height: (width / 1.2))
    layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.register(HorizontalMovieCell.self, forCellWithReuseIdentifier: "HorizontalMovieCell")
    collectionView.isHidden = true
    return collectionView
  }()
  public var viewModel = HorizontalMovieViewModel()
  public let loadIcon: UIActivityIndicatorView = {
    let loadIcon = UIActivityIndicatorView()
    loadIcon.hidesWhenStopped = true
    loadIcon.translatesAutoresizingMaskIntoConstraints = false
    return loadIcon
  }()
  public let uiGroup = DispatchGroup()

  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    setupView()
    setupConstrains()
    uiGroup.enter()
    requesResponse()
    notifyUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func notifyUI() {
    uiGroup.notify(queue: .main) { [weak self] in
      self?.loadIcon.stopAnimating()
      self?.horizontalCollectionView.isHidden = false
      self?.horizontalCollectionView.reloadData()
    }
  }
  
  func requesResponse() {
    viewModel.getFirstList()
    uiGroup.leave()
  }
  
  private func setupConstrains(){
    horizontalCollectionView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    loadIcon.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  private func setupView(){
    horizontalCollectionView.delegate = self
    horizontalCollectionView.dataSource = self
    self.addSubview(horizontalCollectionView)
    self.addSubview(loadIcon)
    loadIcon.startAnimating()
  }
}

extension HorizontalMovieView: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalMovieCell", for: indexPath) as? HorizontalMovieCell else {fatalError()}
    cell.image.downloaded(from: (viewModel.response?.search[indexPath.row].imageUrl)!)
    return cell
  }
  
}

