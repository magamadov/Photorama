//
//  ViewController.swift
//  Photorama
//
//  Created by ZELIMKHAN MAGAMADOV on 23.08.2020.
//

import UIKit

class PhotosViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
  @IBOutlet var collectionView: UICollectionView!
  var store: PhotoStore!
  let photoDataSource = PhotoDataSource()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.dataSource = photoDataSource
    collectionView.delegate = self
    
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
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    
    // Get
    
    let photo = photoDataSource.photos[indexPath.row]
    
    store.fetchImage(for: photo) { (result) in
      guard let photoIndex = self.photoDataSource.photos.firstIndex(of: photo),
            case let .success(image) = result else { return }
      
      let photoIndexPath = IndexPath(item: photoIndex, section: 0)
      
      if let cell = self.collectionView.cellForItem(at: photoIndexPath) as? PhotoCollectionViewCell {
        cell.update(displaying: image)
      }
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let width = (view.bounds.width / 3) - 1
    return CGSize(width: width, height: width)
    
  }
  
}
