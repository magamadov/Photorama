//
//  PhotoStore.swift
//  Photorama
//
//  Created by ZELIMKHAN MAGAMADOV on 24.08.2020.
//

import UIKit

enum PhotoError: Error {
  case imageCreationError
  case missingImageURL
}

class PhotoStore {
  
  let imageStore = ImageStore()
  
  private let session: URLSession = {
    let config = URLSessionConfiguration.default
    return URLSession(configuration: config)
  }()
  
  func fetchInterestingPhoto(completion: @escaping (Result<[Photo], Error>) -> Void) {
    let url = FlickrAPI.interestingPhotosURL
    let request = URLRequest(url: url)
    let task = session.dataTask(with: request) { (data, response, error) in
      let result = self.processPhotoRequest(data: data, error: error)
      OperationQueue.main.addOperation {
        completion(result)
      }
    }
    task.resume()
  }
  
  func fetchImage(for photo: Photo, completion: @escaping (Result<UIImage, Error>) -> Void) {
    let photoKey = photo.photoID
    if let image = imageStore.image(forKey: photoKey) {
      OperationQueue.main.addOperation {
        completion(.success(image))
      }
      return
    }
    
    guard let photoURL = photo.remoteURL else {
      completion(.failure(PhotoError.missingImageURL))
      return
    }
    let request = URLRequest(url: photoURL)
    let task = session.dataTask(with: request) { (data, response, error) in
      let result = self.proccessImageRequest(data: data, error: error)
      if case let .success(image) = result {
        self.imageStore.setImage(image, forKey: photoKey)
      }
      OperationQueue.main.addOperation {
        completion(result)
      }
    }
    task.resume()
  }
  
  private func proccessImageRequest(data: Data?, error: Error?) -> Result<UIImage, Error> {
    guard let imageData = data,
          let image = UIImage(data: imageData) else {
      if data == nil {
        return .failure(error!)
      } else {
        return .failure(PhotoError.imageCreationError)
      }
    }
    return .success(image)
  }
  
  private func processPhotoRequest(data: Data?, error: Error?) -> Result<[Photo], Error> {
    guard let jsonData = data else {
      return .failure(error!)
    }
    return FlickrAPI.photos(fromJSON: jsonData)
  }
}
