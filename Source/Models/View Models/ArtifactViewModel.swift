//
//  ArcheologicalViewModel.swift
//  Arcy
//
//  Created by Matt Novoselov on 02/05/24.
//

import Foundation
import SwiftUI

// ArtifactsCollection is a ViewModel that stores all Artifacts that should be displayed in the collection
struct ArtifactsCollection {
    
    // Array that after initializing stores all information about all artifacts
    var artifacts: [Artifact]
    
    // Initialize View Model on the bootstrap of the Application to parse .csv file and load all Artifacts to the Collection
    init() {
        do {
            // Try to load data from .csv file
            self.artifacts = try ArtifactsCollection.loadArtifactsFromCSV()
        } catch {
            print("Error initializing artifacts collection: \(error)")
            self.artifacts = []
        }
    }
    
    // Function that parses .csv file and loads all Artifacts to the Collection
    // Note: This function should only be called on the bootstrap of the application to avoid resource overload
    private static func loadArtifactsFromCSV() throws -> [Artifact] {
        
        // Try to locate Artifacts.csv file in the Resource folder
        // Note: Artifacts.csv should be included within the directory of the project
        guard let url = Bundle.main.url(forResource: "Artifacts", withExtension: "csv") else {
            throw NSError(domain: "FileNotFoundError", code: 404, userInfo: [NSLocalizedDescriptionKey: "CSV file not found."])
        }
        
        // Load data from the .csv file
        let data = try String(contentsOf: url)
        
        // Devide .csv file to rows
        let lines = data.components(separatedBy: .newlines)
        
        // Define an empty temporary array for storing parsed Artifacts
        var artifacts: [Artifact] = []
        
        // For each row, try to parse information about the Artifact
        for (index, line) in lines.enumerated() {
            
            // Skip header with table names and general information
            if index == 0 { continue }
            
            // Skip empty footer
            if index == lines.count-1 { continue }
            
            // Divide all data in row to columns by semicolon
            // Note: Ensure that you export your .scv file in the correct format
            // Default .scv export from Numbers will result in columns be separated with commas, which will result in an error
            let components = line.components(separatedBy: ";")
            
            // Check that row has sufficient amount of columns
            guard components.count > 6 else {
                throw NSError(domain: "FileBroken", code: 400, userInfo: [NSLocalizedDescriptionKey: "Error: Insufficient components"])
            }
            
            // Trim and extract artifact ID from the .scv
            // Artifact ID is an Int that starts from 0
            guard let artifactIDString = components.first,
                  let artifactID = Int(artifactIDString.trimmingCharacters(in: .whitespaces)) else {
                throw NSError(domain: "FileBroken", code: 400, userInfo: [NSLocalizedDescriptionKey: "Error: Unable to extract artifactID."])
            }
            
            // Coordinate location of the artifact in latitude and longitude
            // Example: (40.753, -73.983)
            let locationString = components[6]
            
            // Separate latitude and longitude
            // Example:
            // From "40.753, -73.983" to [40.753, -73.983]
            let locationComponents = locationString.components(separatedBy: ",")
            
            // Extract and convert latitude and longitude to the appropriate format
            guard locationComponents.count > 1,
                  let latitudeString = locationComponents.first,
                  let longitudeString = locationComponents.last,
                  let latitude = Double(latitudeString.trimmingCharacters(in: .whitespaces)),
                  let longitude = Double(longitudeString.trimmingCharacters(in: .whitespaces)) else {
                throw NSError(domain: "FileBroken", code: 400, userInfo: [NSLocalizedDescriptionKey: "Error: Unable to extract latitude or longitude."])
            }
            
            // Compose Artifact before adding it to the collection
            let artifact = Artifact(artifactID: artifactID,
                                    modelName: components[4],
                                    name: components[1],
                                    description: components[5],
                                    location: (latitude, longitude),
                                    previewImage: components[3])
            
            // Add Artifact to the collection
            artifacts.append(artifact)
        }
        
        // Return all artifacts that were parsed successfully
        return artifacts
    }
}
