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
  
  func update(displaying image: UIImage?) {
    if let imageToDisplay = image {
      spinner.stopAnimating()
      imageView.image = imageToDisplay
    } else {
      spinner.startAnimating()
      imageView.image = nil
    }
  }
  
}
