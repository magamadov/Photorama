//
//  PhotoStore.swift
//  Photorama
//
//  Created by ZELIMKHAN MAGAMADOV on 24.08.2020.
//

import Foundation

class PhotoStore {
  
  private let session: URLSession = {
    let config = URLSessionConfiguration.default
    return URLSession(configuration: config)
  }()
  
  func fetchInterestingPhoto(completion: @escaping ((Result<[Photo], Error>) -> Void)) {
    let url = FlickrAPI.interestingPhotosURL
    let request = URLRequest(url: url)
    let task = session.dataTask(with: request) { (data, response, error) in
      let result = self.processPhotoRequest(data: data, error: error)
      completion(result)
    }
    task.resume()
  }
  
  private func processPhotoRequest(data: Data?, error: Error?) -> Result<[Photo], Error> {
    guard let jsonData = data else {
      return .failure(error!)
    }
    return FlickrAPI.photos(fromJSON: jsonData)
  }
}
