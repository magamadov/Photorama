//
//  FlickrAPI.swift
//  Photorama
//
//  Created by ZELIMKHAN MAGAMADOV on 23.08.2020.
//


/*
 
 Key:
 6e73aae468176526744ebdba3e5943ee
 
 Secret:
 a0676e89bab6db61
 
 */

import Foundation

enum EndPoint: String {
  case interestingPhotos = "flickr.interestingness.getList"
}

struct FlickrAPI {
  private static let baseURLString = "https://api.flickr.com/services/rest"
  private static let apiKey = "6e73aae468176526744ebdba3e5943ee"
  
  static var interestingPhotosURL: URL {
    return flickrURL(endPoint: .interestingPhotos, parametrs: ["extras": "url_z,date_taken"])
  }
  
  private static func flickrURL(endPoint: EndPoint, parametrs: [String:String]?) -> URL {
    var components = URLComponents(string: baseURLString)!
    var queryItems = [URLQueryItem]()
    
    let baseParams = [
      "method": endPoint.rawValue,
      "format": "json",
      "nojsoncallback": "1",
      "api_key": apiKey
    ]
    
    for (key, value) in baseParams {
      let item = URLQueryItem(name: key, value: value)
      queryItems.append(item)
    }
    
    if let additionalParams = parametrs {
      for (key, value) in additionalParams {
        let item = URLQueryItem(name: key, value: value)
        queryItems.append(item)
      }
    }
    
    components.queryItems = queryItems
    return components.url!
  }
}
