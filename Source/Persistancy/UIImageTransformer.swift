//
//  UIImageTransformer.swift
//  Arcy
//
//  Created by Matt Novoselov on 11/05/24.
//

import Foundation
import UIKit

// A custom ValueTransformer subclass for converting UIImage objects to and from Data for CoreData storage.
// This is needed because CoreData is not supporting UIImage storage by default
class UIImageTransformer: ValueTransformer {
    
    // Converts a UIImage to Data.
    override func transformedValue(_ value: Any?) -> Any? {
        // Ensure the input value is a UIImage.
        guard let image = value as? UIImage else { return nil }
        
        do {
            // Archive the UIImage to Data using NSKeyedArchiver.
            let data = try NSKeyedArchiver.archivedData(withRootObject: image, requiringSecureCoding: true)
            return data
        } catch {
            // If an error occurs during archiving, return nil.
            return nil
        }
    }
    
    // Converts Data to a UIImage.
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        // Ensure the input value is Data.
        guard let data = value as? Data else { return nil }
        
        do {
            // Unarchive Data to UIImage using NSKeyedUnarchiver.
            let image = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIImage.self, from: data)
            return image
        } catch {
            // If an error occurs during unarchiving, return nil.
            return nil
        }
    }
    
}

