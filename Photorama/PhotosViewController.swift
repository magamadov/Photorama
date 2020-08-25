//
//  ViewController.swift
//  Photorama
//
//  Created by ZELIMKHAN MAGAMADOV on 23.08.2020.
//

import UIKit

class PhotosViewController: UIViewController {
  
  @IBOutlet private var imageView: UIImageView!
  var store: PhotoStore!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    store.fetchInterestingPhoto { (photosResult) in
      switch photosResult {
        case .success(let photos):
          print("Successfully found: \(photos.count) photos")
          //if let firstPhoto = photos[Int.random(in: 0..<photos.count)] {
          self.updateImageView(for: photos[Int.random(in: 0..<photos.count)])
        //}
        case .failure(let error):
          print("Error fetching interesting photos: \(error)")
      }
    }
  }
  
  func updateImageView(for photo: Photo) {
    store.fetchImage(for: photo) { (imageResult) in
      switch imageResult {
        case .success(let image):
          self.imageView.image = image
          
          
        case .failure(let error):
          print("Error downloading image: \(error)")
      }
    }
  }
  
}
