//
//  Photo+CoreDataProperties.swift
//  Photorama
//
//  Created by ZELIMKHAN MAGAMADOV on 08.09.2020.
//
//

import Foundation
import CoreData


extension Photo {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
    return NSFetchRequest<Photo>(entityName: "Photo")
  }
  
  @NSManaged public var photoID: String?
  @NSManaged public var title: String?
  @NSManaged public var dateTaken: Date?
  @NSManaged public var remoteURL: URL?
  
}
