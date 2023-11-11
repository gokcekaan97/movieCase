//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by kaan gokcek on 11.11.2023.
//

import SnapKit
import UIKit

class MovieDetailCoordinator {
  var router: UINavigationController!
  var movieId: String
  init(router: UINavigationController, movieId: String){
    self.router = router
    self.movieId = movieId
  }
  public func pushCoordinator(animated: Bool,
                      completion: (() -> Void)?) {
    guard let builder = MovieDetailBuilder().build(movieId: movieId) else { return }
      router.pushViewController(builder, animated: true)
  }
}

class MovieDetailBuilder {
  func build(movieId: String) -> UIViewController? {
    let movieDetailViewController = MovieDetailViewController()
    movieDetailViewController.viewModel = MovieDetailViewModel(movieId: movieId)
    return movieDetailViewController
  }
}

class MovieDetailViewController: UIViewController {
  public var viewModel: MovieDetailViewModel?
  public var image: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.isHidden = true
    return imageView
  }()
  public var cellName: UILabel = {
    var label = UILabel()
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    label.isHidden = true
    return label
  }()
  public var cellDescription: UILabel = {
    var label = UILabel()
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    label.isHidden = true
    return label
  }()
  public let loadIcon: UIActivityIndicatorView = {
    let loadIcon = UIActivityIndicatorView()
    loadIcon.hidesWhenStopped = true
    loadIcon.translatesAutoresizingMaskIntoConstraints = false
    return loadIcon
  }()
  public let uiGroup = DispatchGroup()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupSubviews()
    setupConstraints()
    uiGroup.enter()
    initialRequest()
    notifyFirstRequestUI()
  }

  func setupSubviews() {
    self.view.addSubview(image)
    self.view.addSubview(cellName)
    self.view.addSubview(cellDescription)
    self.view.addSubview(loadIcon)
    loadIcon.startAnimating()
  }
  
  func setupConstraints() {
    image.snp.makeConstraints { make in
      make.trailing.top.leading.equalToSuperview()
      make.height.equalTo(image.snp.width)
    }
    cellName.snp.makeConstraints { make in
      make.top.equalTo(image.snp.bottom).offset(16)
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(48)
    }
    cellDescription.snp.makeConstraints { make in
      make.top.equalTo(cellName.snp.bottom).offset(16)
      make.leading.trailing.equalToSuperview()
    }
    loadIcon.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  func notifyFirstRequestUI() {
    uiGroup.notify(queue: .main) { [weak self] in
      DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
        self?.loadIcon.stopAnimating()
        self?.image.downloaded(from: (self?.viewModel?.movieDetail?.imageUrl)!)
        self?.cellName.text = self?.viewModel?.movieDetail?.title
        self?.cellDescription.text = self?.viewModel?.movieDetail?.description
      })
      self?.image.isHidden = false
      self?.cellDescription.isHidden = false
      self?.cellName.isHidden = false
    }
  }
  
  func initialRequest() {
    viewModel?.getMovieDetail()
    uiGroup.leave()
  }
}
