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
    firstRequesResponse()
    notifyFirstRequestUI()
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
  
  func notifyFirstRequestUI() {
    uiGroup.notify(queue: .main) { [weak self] in
      self?.loadIcon.stopAnimating()
      self?.verticalTableView.isHidden = false
      self?.verticalTableView.reloadData()
    }
  }
  
  func moreRequest() {
    if viewModel.searchText == "" {
      viewModel.getListWithPage()
      DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
        self.verticalTableView.reloadData()
      })
    } else {
      viewModel.getListWithPage(viewModel.searchText)
      DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
        self.verticalTableView.reloadData()
      })
    }
  }
  
  func firstRequesResponse() {
    viewModel.getFirstList()
    uiGroup.leave()
  }
}

//MARK: delegate
extension VerticalMovieView: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if viewModel.responseList.count == 0 {
      tableView.isHidden = true
      loadIcon.startAnimating()
    } else {
      tableView.isHidden = false
      loadIcon.stopAnimating()
    }
    return viewModel.responseList.count
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if indexPath.row == viewModel.responseList.endIndex - 4,
       viewModel.searchEnabled == false {
      moreRequest()
    } else if indexPath.row == viewModel.responseList.endIndex - 4,
              viewModel.searchEnabled == true {
      moreRequest()
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "VerticalMovieCell", for: indexPath) as? VerticalMovieCell else {fatalError()}
    if viewModel.responseList.count != 0{
      cell.cellName.text = viewModel.responseList[indexPath.row].title
      cell.cellDescription.text = viewModel.responseList[indexPath.row].year
      cell.image.downloaded(from: (viewModel.responseList[indexPath.row].imageUrl)!)
    }
    return cell
  }
}
