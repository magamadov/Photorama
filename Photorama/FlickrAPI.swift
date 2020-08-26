//
//  FlickrAPI.swift
//  Photorama
//
//  Created by ZELIMKHAN MAGAMADOV on 23.08.2020.
//

import Foundation

enum EndPoint: String {
  case interestingPhotos = "flickr.interestingness.getList"
  case recentPhotos = "flickr.photos.getRecent"
}

struct FlickrAPI {
  private static let baseURLString = "https://api.flickr.com/services/rest"
  private static let apiKey = "6e73aae468176526744ebdba3e5943ee"
  
  static var interestingPhotosURL: URL {
    return flickrURL(endPoint: .interestingPhotos, parametrs: ["extras": "url_z,date_taken"])
  }
  
  static var recentPhotosURL: URL {
    return flickrURL(endPoint: .recentPhotos, parametrs: ["extras": "url_z,date_taken"])
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
  
  static func photos(fromJSON data: Data) -> Result<[Photo], Error> {
    let decoder = JSONDecoder()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dateFormatter.locale = Locale(identifier: "ru_RU")
    dateFormatter.timeZone = TimeZone.current
    decoder.dateDecodingStrategy = .formatted(dateFormatter)
    do {
      let flickrResponse = try decoder.decode(FlickrResponse.self, from: data)
      let photos = flickrResponse.photosInfo.photos.filter { $0.remoteURL != nil }
      return .success(photos)
    } catch {
      return .failure(error)
    }
  }
}

struct FlickrResponse: Codable {
  let photosInfo: FlickrPhotosResponse
  
  enum CodingKeys: String, CodingKey {
    case photosInfo = "photos"
  }
}

struct FlickrPhotosResponse: Codable {
  let photos: [Photo]
  
  enum CodingKeys: String, CodingKey {
    case photos = "photo"
  }
}
