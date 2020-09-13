//
//  PhotoCollectionViewCell.swift
//  Photorama
//
//  Created by ZELIMKHAN MAGAMADOV on 31.08.2020.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var spinner: UIActivityIndicatorView!
  @IBOutlet var viewCounterLabel: UILabel!
  
  func update(displaying image: UIImage?, viewCounter: Int) {
    if let imageToDisplay = image {
      spinner.stopAnimating()
      imageView.image = imageToDisplay
      viewCounterLabel.text = String(viewCounter)
    } else {
      spinner.startAnimating()
      imageView.image = nil
    }
  }
  
}
