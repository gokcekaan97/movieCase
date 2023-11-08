//
//  ViewController.swift
//  MovieApp
//
//  Created by kaan gokcek on 7.11.2023.
//

import UIKit

class MovieViewController: UIViewController {
  
  public var verticalTableView = UITableView()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupSubviews()
    setupConstraints()
    setupTableView()
  }
  
  func setupTableView() {
    verticalTableView.delegate = self
    verticalTableView.dataSource = self
    verticalTableView.register(VerticalMovieCell.self, forCellReuseIdentifier: "MovieCell")
  }

  func setupSubviews() {
    self.view.addSubview(verticalTableView)
  }
  
  func setupConstraints() {
    verticalTableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
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
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as? VerticalMovieCell else {fatalError()}
    cell.cellName.text = "demo"
    cell.cellDescription.text = "demo 1"
    cell.image.image = .none
    return cell
  }
  
  
}
