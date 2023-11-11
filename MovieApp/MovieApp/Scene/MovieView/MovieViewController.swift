//
//  ViewController.swift
//  MovieApp
//
//  Created by kaan gokcek on 7.11.2023.
//

import UIKit
import SnapKit

protocol MovieViewDelegate: AnyObject {
  func didSelectRowTableView(at indexPath: IndexPath)
  func didSelectRowCollectionView(at indexPath: IndexPath)
}

class MovieViewController: UIViewController {
  public var viewModel = MovieViewModel()
  public var verticalTableView = VerticalMovieView()
  public var horizontalCollectionView = HorizontalMovieView()
  public let searchController = UISearchController()
  private var searchTimer: Timer?

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupSubviews()
    setupConstraints()
    setupSearch()
  }

  func setupSubviews() {
    self.view.addSubview(verticalTableView)
    verticalTableView.delegate = self
    self.view.addSubview(horizontalCollectionView)
    horizontalCollectionView.delegate = self
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
  
  func setupSearch() {
    searchController.delegate = self
    searchController.searchBar.delegate = self
    searchController.searchResultsUpdater = self
    self.navigationItem.hidesSearchBarWhenScrolling = false
    self.navigationItem.searchController = searchController
  }
  
  func performSearch(searchController:UISearchController){
    if let len = searchController.searchBar.text?.count, len > 3{
      if let text = searchController.searchBar.text{
        verticalTableView.viewModel.getFirstList(text)
        verticalTableView.viewModel.searchText = text
        DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
          self.verticalTableView.verticalTableView.reloadData()
          if self.verticalTableView.viewModel.responseList.count != 0{
            self.verticalTableView.verticalTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            self.verticalTableView.verticalTableView.isHidden = false
            self.verticalTableView.loadIcon.stopAnimating()
          }
        })
      }
    }
    searchTimer?.invalidate()
  }
}

extension MovieViewController: MovieViewDelegate {
  func didSelectRowCollectionView(at indexPath: IndexPath) {
    MovieDetailCoordinator(
      router: self.navigationController!,
      movieId: horizontalCollectionView.viewModel.responseList[indexPath.row].movieId!
    ).pushCoordinator(animated: true, completion: nil)
  }
  
  func didSelectRowTableView(at indexPath: IndexPath) {
    MovieDetailCoordinator(
      router: self.navigationController!,
      movieId: verticalTableView.viewModel.responseList[indexPath.row].movieId!
    ).pushCoordinator(animated: true, completion: nil)
  }
}

//MARK: delegate
extension MovieViewController: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    searchTimer?.invalidate()
    searchTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { [weak self] _ in
      self?.performSearch(searchController: searchController)
    })
  }
  
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    verticalTableView.viewModel.searchEnabled = true
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if let len = searchController.searchBar.text?.count, len < 3{
      verticalTableView.verticalTableView.isHidden = true
      verticalTableView.loadIcon.startAnimating()
    }
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    verticalTableView.viewModel.searchEnabled = false
    verticalTableView.viewModel.searchText = ""
    verticalTableView.viewModel.getFirstList()
    DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
      self.verticalTableView.verticalTableView.reloadData()
      self.verticalTableView.verticalTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    })
  }
}
