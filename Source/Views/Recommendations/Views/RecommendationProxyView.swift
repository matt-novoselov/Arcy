//
//  RecommendationProxyView.swift
//  Arcy
//
//  Created by Matt Novoselov on 19/05/24.
//

import SwiftUI
import SwiftData

// RecommendationProxyView is a link between RecommendationView and SwiftData
// this View is supposed to get stored in SwiftData likeModel
struct RecommendationProxyView: View {
    
    // Get stored artifacts with likes from SwiftData model
    @Query var storedLikedArtifacts: [LikeModel]
    
    // Load all artifacts from the collection
    let artifactCollection: [Artifact]
    
    // Display main RecommendationView
    var body: some View {
        RecommendationView(compiledModel: compileModel(), artifactCollection: artifactCollection)
    }
    
//
//     Compile a data model that will be passed to the ML model for analyzation
//     Go through each stored liked artifact
//     and transform it to the format of dictionary
//     where: [ArtifactID : isLiked]
//     isLiked = true = 1
//     isLiked = false = 0
//    
//     The ratings are need to be given in Double value that is between 0 and 1,
//     so the model can correctly represent the data
//    
//     example: [12 : 1]
//     12 is an ID of an Artifact and 1 represents that this artifact has been liked
//    
    
    func compileModel() -> [Int64: Double] {
        var compiledModel: [Int64: Double] = [:]
        
        for artifact in storedLikedArtifacts {
            let ratingValue = artifact.isLiked ? 1.0 : 0.0
            compiledModel[Int64(artifact.artifactID)] = ratingValue
        }
        
        return compiledModel
    }
}
