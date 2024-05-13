//
//  CoreDataManager.swift
//  Arcy
//
//  Created by Matt Novoselov on 11/05/24.
//

import Foundation
import CoreData

// A class responsible for managing the Core Data stack and providing access to the managed object context.
class CoreDataManager {
    
    // The container for the Core Data stack.
    let persistentContainer: NSPersistentContainer
    
    // Shared instance of CoreDataManager, following the singleton pattern.
    static let shared: CoreDataManager = CoreDataManager()
    
    // Private initializer to prevent external instantiation.
    private init() {
        
        // Registering a custom value transformer to handle UIImage serialization/deserialization.
        ValueTransformer.setValueTransformer(UIImageTransformer(), forName: NSValueTransformerName("UIImageTransformer"))
        
        // Initializing the persistent container with the specified model name.
        persistentContainer = NSPersistentContainer(name: "PhotosModel")
        
        // Loading the persistent stores associated with the container.
        persistentContainer.loadPersistentStores { description, error in
            // Handling any errors that occur during persistent store loading.
            if let error = error {
                fatalError("Unable to initialize Core Data \(error)")
            }
        }
    }
}

