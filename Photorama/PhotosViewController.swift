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
    
    updateDataSource()
    
    store.fetchInterestingPhoto { (photosResult) in
      self.updateDataSource()
    }
    
    NotificationCenter.default.addObserver(self, selector: #selector(updateDataSource), name: NSNotification.Name("reload"), object: nil)
    
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    
    let photo = photoDataSource.photos[indexPath.row]
    let favorite = photo.favorite
    
    store.fetchImage(for: photo) { (result) in
      
      guard let photoIndex = self.photoDataSource.photos.firstIndex(of: photo),
            case let .success(image) = result else { return }
      
      let photoIndexPath = IndexPath(item: photoIndex, section: 0)
      
      if let cell = self.collectionView.cellForItem(at: photoIndexPath) as? PhotoCollectionViewCell {
        cell.update(displaying: image, viewCounter: Int(photo.viewsCounter), favorite: favorite)
      }
    }
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    let width = (view.bounds.width / 3) - 1
    layout.itemSize = CGSize(width: width, height: width)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
      case "showPhoto":
        if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first {
          let photo = photoDataSource.photos[selectedIndexPath.row]
          let destinationVC = segue.destination as! PhotoInfoViewController
          destinationVC.photo = photo
          destinationVC.store = store
          destinationVC.photosViewController = self
        }
      default:
        preconditionFailure("Unexpected segue identifier!")
    }
  }
  
  @objc func updateDataSource() {
    store.fetchAllPhotos { (photosResult) in
      switch photosResult {
        case let .success(photos):
          
          var photos = photos
          
          if self.photoDataSource.type == .favs {
            photos = photos.filter { $0.favorite }
          }
          
          self.photoDataSource.photos = photos
          
        case .failure:
          self.photoDataSource.photos.removeAll()
      }
      self.collectionView.reloadSections(IndexSet(integer: 0))
    }
  }
  
  
  @IBAction func viewDidChange(_ sender: UISegmentedControl) {
    
    switch sender.selectedSegmentIndex {
    case 0:
      photoDataSource.type = .all
      updateDataSource()
    case 1:
      photoDataSource.type = .favs
      updateDataSource()
    default:
      break
    }
  }
}
