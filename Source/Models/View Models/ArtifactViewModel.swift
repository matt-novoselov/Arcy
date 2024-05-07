//
//  ArcheologicalViewModel.swift
//  Arcy
//
//  Created by Matt Novoselov on 02/05/24.
//

import Foundation
import SwiftUI

struct ArtifactsCollection {
    var artifacts: [Artifact]
    
    init() {
        do {
            self.artifacts = try ArtifactsCollection.loadArtifactsFromCSV()
        } catch {
            // Handle error here, such as logging or showing an alert
            print("Error initializing artifacts collection: \(error)")
            self.artifacts = []
        }
    }
    
    private static func loadArtifactsFromCSV() throws -> [Artifact] {
        guard let url = Bundle.main.url(forResource: "Artifacts", withExtension: "csv") else {
            throw NSError(domain: "FileNotFoundError", code: 404, userInfo: [NSLocalizedDescriptionKey: "CSV file not found."])
        }
        
        let data = try String(contentsOf: url)
        let lines = data.components(separatedBy: .newlines)
        var artifacts: [Artifact] = []
        
        for (index, line) in lines.enumerated() {
            if index == 0 { continue } // Skip header
            if index == lines.count-1 { continue }
            
            let components = line.components(separatedBy: ";")
            
            // Guard for artifactID
            guard let artifactIDString = components.first,
                  let artifactID = Int(artifactIDString.trimmingCharacters(in: .whitespaces)) else {
                print(components)
                print(artifacts.count)
                print("Error: Unable to extract artifactID")
                throw NSError(domain: "FileBroken", code: 400, userInfo: [NSLocalizedDescriptionKey: "CSV file is broken."])
            }
            
            // Guard for locationComponents
            guard components.count > 6 else {
                print("Error: Insufficient components")
                // Handle the error condition here, if necessary
                // For example, return or throw an error
                throw NSError(domain: "FileBroken", code: 400, userInfo: [NSLocalizedDescriptionKey: "CSV file is broken."])
            }
            
            let locationString = components[6]
            // Now you can use locationString safely
            
            
            let locationComponents = locationString.components(separatedBy: ",")
            
            // Guard for latitude and longitude
            guard locationComponents.count > 1,
                  let latitudeString = locationComponents.first,
                  let longitudeString = locationComponents.last,
                  let latitude = Double(latitudeString.trimmingCharacters(in: .whitespaces)),
                  let longitude = Double(longitudeString.trimmingCharacters(in: .whitespaces)) else {
                print("Error: Unable to extract latitude or longitude")
                throw NSError(domain: "FileBroken", code: 400, userInfo: [NSLocalizedDescriptionKey: "CSV file is broken."])
            }
            
            // Continue with latitude and longitude variables
            
            let artifact = Artifact(artifactID: artifactID,
                                    modelName: components[4],
                                    name: components[1],
                                    description: components[5],
                                    location: (latitude, longitude),
                                    previewImage: components[3])
            artifacts.append(artifact)
        }
        
        return artifacts
    }
}
