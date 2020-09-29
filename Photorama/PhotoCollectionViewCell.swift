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
  
  var photoDescription: String?
  
  override var accessibilityLabel: String? {
    get {
      return photoDescription
    }
    set {
      
    }
  }
  
  override var isAccessibilityElement: Bool {
    get {
      return true
    }
    set {
      
    }
  }
  
  override var accessibilityTraits: UIAccessibilityTraits {
    get {
      return super.accessibilityTraits.union([.image, .button])
    }
    set {
      
    }
  }
  
  func update(displaying image: UIImage?, viewCounter: Int, favorite: Bool) {
    
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
