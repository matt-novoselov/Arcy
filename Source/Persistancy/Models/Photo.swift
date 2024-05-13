//
//  Photo.swift
//  Arcy
//
//  Created by Matt Novoselov on 11/05/24.
//

import Foundation
import CoreData
import UIKit

// A managed object subclass representing a photo entity in Core Data.
@objc(Photo)
class Photo: NSManagedObject {
    
    // Returns a fetch request for the Photo entity.
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }
    
    // The content of the photo, represented as a UIImage.
    @NSManaged public var content: UIImage?
    
}
