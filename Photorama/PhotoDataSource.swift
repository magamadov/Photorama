//
//  PhotoDataSource.swift
//  Photorama
//
//  Created by ZELIMKHAN MAGAMADOV on 29.08.2020.
//

import UIKit

enum PhotoSourceType {
  case all
  case favs
}

class PhotoDataSource: NSObject, UICollectionViewDataSource {
  
  var photos = [Photo]()
  var type: PhotoSourceType = .all
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return photos.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let identifier = "PhotoCollectionViewCell"
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! PhotoCollectionViewCell
    cell.update(displaying: nil, viewCounter: 0, favorite: false)
    
    return cell
  }
}
