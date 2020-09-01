//
//  PhotoInfoViewController.swift
//  Photorama
//
//  Created by ZELIMKHAN MAGAMADOV on 01.09.2020.
//

import UIKit

class PhotoInfoViewController: UIViewController {
  
  @IBOutlet var imageView: UIImageView!
  
  var photo: Photo! {
    didSet {
      navigationItem.title = photo.title
    }
  }
  
  var store: PhotoStore!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    store.fetchImage(for: photo) { (result) in
      switch result {
        case .success(let image):
          self.imageView.image = image
        case .failure(let error):
          print("Error fetching image for photo: \(error)")
      }
    }
  }
  
}
