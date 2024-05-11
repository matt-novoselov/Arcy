//
//  PhotosViewModel.swift
//  Arcy
//
//  Created by Matt Novoselov on 11/05/24.
//

import Foundation
import UIKit
import CoreData

@Observable
class PhotoViewModel {
    
    var image: UIImage?
    private var context = CoreDataManager.shared.persistentContainer.viewContext
    
    
    init() {
        
        let request: NSFetchRequest<Photo> = NSFetchRequest(entityName: "Photo")
        
        do {
            let photos: [Photo] = try context.fetch(request)
            if let photo = photos.first {
                self.image = photo.content
            }
        } catch {
            print(error)
        }
        
    }
    
    func saveImage(_ image: UIImage) {
        // Delete all existing photos
        deleteAllPhotos()
        
        let photo = Photo(context: self.context)
        photo.content = image
        
        do {
            try self.context.save()
            
            DispatchQueue.main.async {
                self.image = photo.content
            }
        } catch {
            print("Error saving photo: \(error)")
        }
    }

    private func deleteAllPhotos() {
        let request: NSFetchRequest<Photo> = NSFetchRequest(entityName: "Photo")
        do {
            let photos: [Photo] = try context.fetch(request)
            for photo in photos {
                context.delete(photo)
            }
        } catch {
            print("Error deleting photos: \(error)")
        }
    }

    private func fetchExistingPhoto() -> Photo? {
        let request: NSFetchRequest<Photo> = NSFetchRequest(entityName: "Photo")
        do {
            let photos: [Photo] = try context.fetch(request)
            return photos.first
        } catch {
            print("Error fetching existing photo: \(error)")
            return nil
        }
    }
    
}
