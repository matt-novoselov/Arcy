//
//  PhotosViewModel.swift
//  Arcy
//
//  Created by Matt Novoselov on 11/05/24.
//

import Foundation
import UIKit
import CoreData

// A view model for managing photo data and interactions
@Observable
class PhotoViewModel {
    
    // The image managed by the view model.
    var image: UIImage?
    
    // The managed object context used for Core Data operations.
    private var context = CoreDataManager.shared.persistentContainer.viewContext
    
    // Initializes the view model, fetching the first photo if available.
    init() {
        // Fetch the first photo from Core Data.
        let request: NSFetchRequest<Photo> = NSFetchRequest(entityName: "Photo")
        do {
            let photos: [Photo] = try context.fetch(request)
            if let photo = photos.first {
                self.image = photo.content
            }
        } catch {
            // Handle any errors that occur during fetching.
            print(error)
        }
    }
    
    // Saves the given image as a new photo, replacing any existing photos.
    func saveImage(_ image: UIImage) {
        // Delete all existing photos before saving the new one.
        // Ensure one and only one profile photo is stored
        deleteAllPhotos()
        
        // Create a new photo object in the managed object context.
        let photo = Photo(context: self.context)
        photo.content = image
        
        do {
            // Save the changes to the managed object context.
            try self.context.save()
            
            // Update the image property on the main thread.
            DispatchQueue.main.async {
                self.image = photo.content
            }
        } catch {
            // Handle any errors that occur during saving.
            print("Error saving photo: \(error)")
        }
    }
    
    // Deletes all photos from the managed object context.
    private func deleteAllPhotos() {
        let request: NSFetchRequest<Photo> = NSFetchRequest(entityName: "Photo")
        do {
            let photos: [Photo] = try context.fetch(request)
            for photo in photos {
                context.delete(photo)
            }
        } catch {
            // Handle any errors that occur during deletion.
            print("Error deleting photos: \(error)")
        }
    }
    
    // Fetches the first photo from the managed object context.
    private func fetchExistingPhoto() -> Photo? {
        let request: NSFetchRequest<Photo> = NSFetchRequest(entityName: "Photo")
        do {
            let photos: [Photo] = try context.fetch(request)
            return photos.first
        } catch {
            // Handle any errors that occur during fetching.
            print("Error fetching existing photo: \(error)")
            return nil
        }
    }
    
}
