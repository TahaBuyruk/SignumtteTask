//
//  Styles.swift
//  Moviefy
//
//  Created by Taha Eren Buyruk  on 7.09.2020.
//  Copyright © 2020 TEB. All rights reserved.
//

import Foundation
import UIKit

struct Styles {
  static let defaultSpace: CGFloat = 8
  
  enum FontFamily: String {
    case ubuntu = "Ubuntu"
  }
  
  enum FontWeight: String {
    case black = "Black"
    case bold = "Bold"
    case medium = "Medium"
    case regular = "Regular"
    case semibold = "Thin"
    case light = "Light"
  }
  
  enum FontSize: CGFloat {
    case xxsmall = 10
    case xsmall = 12
    case small = 14
    case medium = 16
    case large = 18
    case xlarge = 20
    case xxlarge = 25
  }
  
  static func font(with family: FontFamily, weight: FontWeight, size: FontSize) -> UIFont {
    return UIFont(name: family.rawValue + "-" + weight.rawValue, size: size.rawValue) ?? UIFont.systemFont(ofSize: size.rawValue)
  }
}
