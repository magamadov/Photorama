//
//  PhotoInfoViewController.swift
//  Photorama
//
//  Created by ZELIMKHAN MAGAMADOV on 01.09.2020.
//

import UIKit

class PhotoInfoViewController: UIViewController {
  
  var photosViewController: PhotosViewController?
  
  @IBOutlet var viewsImageView: UIImageView!
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var viewsCounter: UILabel!
  @IBOutlet weak var favoriteButton: UIBarButtonItem!
  
  var photo: Photo! {
    didSet {
      navigationItem.title = photo.title
    }
  }
  
  var store: PhotoStore!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    imageView.addObserver(self, forKeyPath: "image", options: .new, context: .none)
    viewsImageView.image = UIImage(systemName: "eye")
    
    store.fetchImage(for: photo) { (result) in
      switch result {
        case .success(let image):
          self.imageView.image = image
          
          if self.photo.favorite {
            self.favoriteButton.image = UIImage(systemName: "star.fill")
          } else {
            self.favoriteButton.image = UIImage(systemName: "star")
          }
        
        case .failure(let error):
          print("Error fetching image for photo: \(error)")
      }
    }
  }
  
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    let context = store.persistentContainer.viewContext
    context.perform {
      self.photo.viewsCounter += 1
      self.viewsCounter.text = "\(self.photo.viewsCounter)"
      self.photosViewController?.updateDataSource()
    }
    do {
      try store.persistentContainer.viewContext.save()
    } catch {
      print("Failed to save the viewCounters: \(error)")
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showTags" {
      
      let navController = segue.destination as! UINavigationController
      let tagController = navController.topViewController as! TagsViewController
      
      tagController.store = store
      tagController.photo = photo
      
    } else {
      preconditionFailure("Unexpected segue id")
    }
  }
  @IBAction func addToFavorite(_ sender: UIBarButtonItem) {
    
    if photo.favorite {
      photo.favorite = false
      favoriteButton.image = UIImage(systemName: "star")
    } else {
      photo.favorite = true
      favoriteButton.image = UIImage(systemName: "star.fill")
    }
    
    do {
      try store.persistentContainer.viewContext.save()
    } catch {
      print("Favorites saving failed: \(error)")
    }
    
    NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
    
  }
}
