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
  
  private let session: URLSession = {
    let config = URLSessionConfiguration.default
    return URLSession(configuration: config)
  }()
  
  func fetchPhotos(category: EndPoint, completion: @escaping (Result<[Photo], Error>) -> Void) {
    let url: URL!
    
    switch category {
      case .interestingPhotos:
        url = FlickrAPI.interestingPhotosURL
      case .recentPhotos:
        url = FlickrAPI.recentPhotosURL
    }
    
    let request = URLRequest(url: url)
        
    let task = session.dataTask(with: request) { (data, response, error) in
      let result = self.processPhotoRequest(data: data, error: error)
    
      // Bronze Challenge: Printing the Response Information
      
      if let httpResponse = response as? HTTPURLResponse {
        let statusCode = httpResponse.statusCode
        print("Status code: \(statusCode)")
        for (key, value) in httpResponse.allHeaderFields {
          print("\(key): \(value)")
        }
      }
      
      OperationQueue.main.addOperation {
        completion(result)
      }
    }
    task.resume()
  }
  
  func fetchImage(for photo: Photo, completion: @escaping (Result<UIImage, Error>) -> Void) {
    guard let photoURL = photo.remoteURL else {
      completion(.failure(PhotoError.missingImageURL))
      return
    }
    let request = URLRequest(url: photoURL)
    let task = session.dataTask(with: request) { (data, response, error) in
      let result = self.proccessImageRequest(data: data, error: error)
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
