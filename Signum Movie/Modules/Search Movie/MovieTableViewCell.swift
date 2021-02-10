//
//  MovieTableViewCell.swift
//  Signum Movie
//
//  Created by Taha Eren Buyruk on 10.02.2021.
//

import UIKit
import Kingfisher

final class MovieTableViewCell: UITableViewCell {
  @IBOutlet var coverimageView: UIImageView!
  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var dateLabel: UILabel!
  @IBOutlet var overviewLabel: UILabel!
  
  func configure(with movie: Movie) {
    coverimageView.kf.indicatorType = .activity
    coverimageView.kf.setImage(with: URL(string: "\(movie.poster)"))
    nameLabel.text = movie.title
    dateLabel.text = movie.year
    overviewLabel.text = movie.type
  }
}
