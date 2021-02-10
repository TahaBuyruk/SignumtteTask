//
//  SearchViewController.swift
//  Signum Movie
//
//  Created by Taha Eren Buyruk on 10.02.2021.
//

import UIKit
import RxSwift

final class SearchViewController: BaseViewController, UISearchBarDelegate {
  private let viewModel = SearchViewModel()
  
  @IBOutlet weak var movieTableView: UITableView!
  private let searchController = UISearchController(searchResultsController: nil)
  private var isSearching = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.searchController = searchController
    searchController.searchBar.delegate = self
    searchController.obscuresBackgroundDuringPresentation = false
    
    viewModel.moviesSuccess
      .observeOn(MainScheduler.instance)
      .subscribe(onNext: { [weak self] status in
        guard let self = self else { return }
        self.movieTableView.reloadData()
      }).disposed(by: viewModel.disposeBag)
    
    viewModel.gotError
      .observeOn(MainScheduler.instance)
      .subscribe(onNext: { [weak self] errorMessage in
        guard let self = self else { return }
        //TODO: Notify user
      }).disposed(by: viewModel.disposeBag)
  }
}

extension SearchViewController: UISearchControllerDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let searchedText = searchBar.text else { return }
    viewModel.getMovieBy(searchedText: searchedText)
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    movieTableView.reloadData()
  }
}

extension SearchViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.movies.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifier.movieTableView, for: indexPath) as! MovieTableViewCell
    cell.configure(with: viewModel.movies[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
}
