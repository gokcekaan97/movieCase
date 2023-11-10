//
//  ViewController.swift
//  MovieApp
//
//  Created by kaan gokcek on 7.11.2023.
//

import UIKit

class MovieViewController: UIViewController {
  public var viewModel = MovieViewModel()
  public var verticalTableView = UITableView()
  public var horizontalCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let width = UIScreen.main.bounds.width/2
    layout.itemSize = CGSize(width: width, height: (width / 1.2))
    layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupSubviews()
    setupConstraints()
    setupTableView()
    setupCollectionView()
  }
  
  func setupCollectionView() {
    horizontalCollectionView.delegate = self
    horizontalCollectionView.dataSource = self
    horizontalCollectionView.register(HorizontalMovieCell.self, forCellWithReuseIdentifier: "HorizontalMovieCell")
  }
  
  func setupTableView() {
    verticalTableView.delegate = self
    verticalTableView.dataSource = self
    verticalTableView.register(VerticalMovieCell.self, forCellReuseIdentifier: "MovieCell")
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

//MARK: TableView delegate & datasource
extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? VerticalMovieCell else {fatalError()}
    cell.cellName.text = "demo"
    cell.cellDescription.text = "demo 1"
    cell.image.image = .none
    return cell
  }
}

//MARK: CollectionView delegate & datasource
extension MovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalMovieCell", for: indexPath) as? HorizontalMovieCell else {fatalError()}
    cell.image.image = .none
    return cell
  }
  
}
