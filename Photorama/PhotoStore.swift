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
  
  func fetchInterestingPhoto() {
    let url = FlickrAPI.interestingPhotosURL
    let request = URLRequest(url: url)
    
    let task = session.dataTask(with: request) { (data, response, error) in
      if let jsonData = data {
        if let jsonString = String(data: jsonData, encoding: .utf8) {
          print(jsonString)
        }
      } else if let requestError = error {
        print("Error: \(requestError)")
      } else {
        print("Unexecuted error with the request!")
      }
    }
    task.resume()
  }
  
  
  
}
