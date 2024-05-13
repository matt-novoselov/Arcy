//
//  ArcheologicalModel.swift
//  Arcy
//
//  Created by Matt Novoselov on 02/05/24.
//

import Foundation

// Artifact model for a single archeological item that is being displayed inside of the app
struct Artifact: Identifiable {
    
    // Generate UUID
    var id: UUID = UUID()
    
    // Store ID of an artifact
    // Starts from 0
    var artifactID: Int
    
    // Name of the 3D model that represents the artifact
    // Note: Pass only the name of the model in the .usdz format without an extension itself
    // Example:
    // If the model in the Resource folder is named MyModel.usdz, you only need to pass MyModel
    var modelName: String
    
    // Title that will be displayed near the Artifact. Usually it's the name of the archeological item
    // Note: Try to keep it as short as possible
    var name: String
    
    // Full length description about the artifact that will be displayed inside of the Detail View
    var description: String
    
    // Coordinate location of the artifact in latitude and longitude
    // Example: (40.753, -73.983)
    var location: (latitude: Double, longitude: Double)
    
    // Image that is displayed in the grid before opening the Detail View. Should be a rendered .png image with transparent background
    var previewImage: String
}
