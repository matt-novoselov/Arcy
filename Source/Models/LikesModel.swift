//
//  LikesModel.swift
//  Arcy
//
//  Created by Matt Novoselov on 06/05/24.
//

import Foundation
import SwiftData

// Persistency Model is responsible for storing likes that user puts on Artifacts
@Model
class LikeModel: Identifiable{
    
    // Generate UUID
    var id: UUID = UUID()
    
    // Store ID of an artifact
    // Starts from 0
    var artifactID: Int
    
    // Bool that controls if an Artifact is currently liked or not
    var isLiked: Bool
    
    // Initializer
    init(artifactID: Int, isLiked: Bool) {
        self.artifactID = artifactID
        self.isLiked = isLiked
    }
}
