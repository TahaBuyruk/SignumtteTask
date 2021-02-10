//
//  APIService.swift
//  Google News
//
//  Created by Taha Eren Buyruk.
//  Copyright © 2020 TEB. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire
import Alamofire

protocol APIServiceProtocol {
  func searchMovie(searchedText: String) -> Single<SearchResponse?>
}

enum Endpoint: String {
  case base
  
  func searchUrl(searchedText: String) -> URL {
    return URL(string: Config.baseUrl + "?s=\(searchedText)")!
  }
  
  func movieDetailUrl(id: String) -> URL {
    return URL(string: Config.baseUrl + "?id=\(id)")!
  }
}

final class APIService: APIServiceProtocol {
  private let manager = HTTPManager.shared
  
  private var headers: [String: String] = [
    "x-rapidapi-key": Config.apiKey,
    "x-rapidapi-host": Config.host
  ]
  
  private let SUCCESS = 200
  
  private let disposeBag = DisposeBag()
  
  func searchMovie(searchedText: String) -> Single<SearchResponse?> {
    return request(methodType: .get, url: Endpoint.base.searchUrl(searchedText: searchedText))
  }
  
  
  private func request<T: Decodable>(methodType: HTTPMethod, url: URL, headers: [String: String] = [
    "Content-Type": "application/json"
  ], encoding: ParameterEncoding = JSONEncoding.default, parameters: [String: AnyObject]? = nil) -> Single<T?> {
    
    
    return manager.rx.responseString(methodType, url, parameters: parameters, encoding: encoding)
      .observeOn(ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1)))
      .asSingle()
      .catchError { error -> Single<(HTTPURLResponse, String)> in
        return Single.error(APIError(with: .unknown, message: error.localizedDescription))
      }
      .flatMap { [weak self] json -> Single<T?> in
        guard let self = self else { return Single.just(nil) }
        
        let statusCode = json.0.statusCode
        let jsonString = json.1
        
        print("🔗 URL: " + url.absoluteString)
        print("🎯 Method Type: " + methodType.rawValue)
        print("🎰 Status Code: " + statusCode.description)
        print("🎉 Response: " + jsonString)
        
        guard let data = jsonString.data(using: .utf8) else { return Single.just(nil) }
        
        if statusCode == self.SUCCESS {
          if let response = try? JSONDecoder().decode(T.self, from: data) {
            return Single.just(response)
          } else {
            let errorType = APIErrorType.allValues.filter { statusCode == $0.rawValue }.first ?? .mapping
            let error = APIError(with: errorType, message: "error")
            
            return Single.error(error)
          }
        }
        
        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
        let errorType = APIErrorType.allValues.filter { statusCode == $0.rawValue }.first ?? .unknown
        let error = APIError(with: errorType, message: errorResponse.statusMessage)
        
        return Single.error(error)
      }
  }
  
  final class HTTPManager: Alamofire.SessionManager {
    static let shared: SessionManager = {
      let configuration = URLSessionConfiguration.default
      configuration.timeoutIntervalForRequest = Constants.timeout
      configuration.timeoutIntervalForResource = Constants.timeout
      
      return SessionManager(configuration: configuration, delegate: SessionDelegate())
    }()
  }
}
