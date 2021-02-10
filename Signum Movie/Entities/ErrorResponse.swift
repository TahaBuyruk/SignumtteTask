//
//  ErrorResponse.swift
//  Moviefy
//
//  Created by Taha Eren Buyruk  on 7.11.2020
//  Copyright © 2020 TEB. All rights reserved.
//

import Foundation

final class ErrorResponse: Decodable {
  let statusMessage: String
  let success: Bool
  let statusCode: Int
  
  enum CodingKeys: String, CodingKey {
    case statusMessage = "status_message"
    case success
    case statusCode = "status_code"
  }
  
  init(statusMessage: String, success: Bool, statusCode: Int) {
    self.statusMessage = statusMessage
    self.success = success
    self.statusCode = statusCode
  }
}
