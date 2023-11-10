//
//  VerticalMovieView.swift
//  MovieApp
//
//  Created by kaan gokcek on 10.11.2023.
//

import UIKit
import SnapKit

class VerticalMovieView: UIView {
  public var verticalTableView: UITableView = {
    let tableView = UITableView()
    tableView.register(VerticalMovieCell.self, forCellReuseIdentifier: "VerticalMovieCell")
    tableView.isHidden = true
    return tableView
  }()
  public var viewModel = VerticalMovieViewModel()
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
  
  private func setupConstrains(){
    verticalTableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    loadIcon.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  private func setupView(){
    verticalTableView.delegate = self
    verticalTableView.dataSource = self
    self.addSubview(verticalTableView)
    self.addSubview(loadIcon)
    loadIcon.startAnimating()
  }
  
  func notifyUI() {
    uiGroup.notify(queue: .main) { [weak self] in
      self?.loadIcon.stopAnimating()
      self?.verticalTableView.isHidden = false
      self?.verticalTableView.reloadData()
    }
  }
  
  func requesResponse() {
    viewModel.getFirstList()
    uiGroup.leave()
  }
}

extension VerticalMovieView: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "VerticalMovieCell", for: indexPath) as? VerticalMovieCell else {fatalError()}
    cell.cellName.text = viewModel.response?.search[indexPath.row].title
    cell.cellDescription.text = viewModel.response?.search[indexPath.row].year
    cell.image.image = .none
    return cell
  }
}
