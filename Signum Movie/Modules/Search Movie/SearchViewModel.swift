//
//  SearchViewModel.swift
//  Signum Movie
//
//  Created by Taha Eren Buyruk on 10.02.2021.
//

import Foundation
import RxSwift

final class SearchViewModel: BaseViewModel {
  let moviesSuccess: PublishSubject<Bool>
  let gotError: PublishSubject<String>
  var movies: [Movie] = []
  
  override init() {
    moviesSuccess = PublishSubject<Bool>()
    gotError = PublishSubject<Bool>()
  }
  
  func getMovieBy(searchedText: String) {
    service.searchMovie(searchedText: searchedText)
    .observeOn(MainScheduler.instance)
      .subscribe(onSuccess: { [weak self] response in
        guard let self = self else { return }
        guard let movies = response?.movie else { return }
        self.movies = movies
        self.moviesSuccess.onNext(true)
      }) { [weak self] error in
        guard let self = self else { return }
        self.gotError.onNext(error.localizedDescription)
    }.disposed(by: disposeBag)
  }
}
