//
//  Photo.swift
//  Photorama
//
//  Created by ZELIMKHAN MAGAMADOV on 24.08.2020.
//

import Foundation

// Codable (Decoder protocol) generates the default init

class Photo: Codable {
  let title: String
  let remoteURL: URL?
  let photoID: String
  let dateTaken: Date
  
  enum CodingKeys: String, CodingKey {
    case title
    case remoteURL = "url_z"
    case photoID = "id"
    case dateTaken = "datetaken"
  }
}

