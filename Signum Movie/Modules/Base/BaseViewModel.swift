//
//  BaseViewModel.swift
//  Signum Movie
//
//  Created by Taha Eren Buyruk on 10.02.2021.
//

import Foundation

import Foundation
import RxSwift

class BaseViewModel {
  let service: APIServiceProtocol = APIService()
  let disposeBag = DisposeBag()
}
