//
//  ViewController.swift
//  Photorama
//
//  Created by ZELIMKHAN MAGAMADOV on 23.08.2020.
//

import UIKit

class PhotosViewController: UIViewController, UICollectionViewDelegate {
  
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
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    let width = (view.bounds.width / 4) - 3
    layout.itemSize = CGSize(width: width, height: width)
  }
  
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//    let height = (view.bounds.width / 2) - 1
//    //let width = (view.bounds.width / 2) - 1
//    return CGSize(width: height, height: height)
//  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
      case "showPhoto":
        if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first {
          let photo = photoDataSource.photos[selectedIndexPath.row]
          let destinationVC = segue.destination as! PhotoInfoViewController
          destinationVC.photo = photo
          destinationVC.store = store
        }
      default:
        preconditionFailure("Unexpected segue identifier!")
    }
  }
}
