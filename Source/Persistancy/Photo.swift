//
//  Photo.swift
//  Arcy
//
//  Created by Matt Novoselov on 11/05/24.
//

import Foundation
import CoreData
import UIKit

@objc(Photo)
class Photo: NSManagedObject{
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var content: UIImage?
    
}
