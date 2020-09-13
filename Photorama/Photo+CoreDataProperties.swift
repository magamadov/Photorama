//
//  Photo+CoreDataProperties.swift
//  Photorama
//
//  Created by ZELIMKHAN MAGAMADOV on 11.09.2020.
//
//

import Foundation
import CoreData


extension Photo {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
    return NSFetchRequest<Photo>(entityName: "Photo")
  }
  
  @NSManaged public var dateTaken: Date?
  @NSManaged public var photoID: String?
  @NSManaged public var remoteURL: URL?
  @NSManaged public var title: String?
  @NSManaged public var viewsCounter: Int64
  
}
