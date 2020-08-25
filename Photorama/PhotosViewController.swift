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
        case .success(let photo):
          print("Successfully found: \(photo.count) photos")
        case .failure(let error):
          print("Error fetching interesting photos: \(error)")
      }
    }
  }
}
