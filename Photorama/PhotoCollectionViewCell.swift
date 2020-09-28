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
  @IBOutlet weak var isFavorite: UIImageView!
  
  func update(displaying image: UIImage?, viewCounter: Int, favorite: Bool) {
  //func update(displaying image: UIImage?, viewCounter: Int) {
    if let imageToDisplay = image {
      spinner.stopAnimating()
      imageView.image = imageToDisplay
      viewCounterLabel.text = String(viewCounter)
      
      if favorite {
        self.isFavorite.image = UIImage(systemName: "star.fill")
      } else {
        self.isFavorite.image = nil
      }
      
    } else {
      spinner.startAnimating()
      imageView.image = nil
    }
  }
  
}
