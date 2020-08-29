//
//  ViewController.swift
//  Photorama
//
//  Created by ZELIMKHAN MAGAMADOV on 23.08.2020.
//

import UIKit

class PhotosViewController: UIViewController {
  
  @IBOutlet var collectionView: UICollectionView!
  var store: PhotoStore!
  let photoDataSource = PhotoDataSource()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.dataSource = photoDataSource
    
    store.fetchInterestingPhoto { (photosResult) in
      switch photosResult {
        case .success(let photos):
          print("Successfully found: \(photos.count) photos")
          self.photoDataSource.photos = photos
        case .failure(let error):
          print("Error fetching interesting photos: \(error)")
          self.photoDataSource.photos.removeAll()
      }
      self.collectionView.reloadSections(IndexSet(integer: 0))
    }
  }
  
}
