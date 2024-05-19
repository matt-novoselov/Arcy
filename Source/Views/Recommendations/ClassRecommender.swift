//
//  ClassRecommender.swift
//  Arcy
//
//  Created by Matt Novoselov on 19/05/24.
//

import Foundation
import CoreML

// The Recommender class is where the recommender model makes predictions based on user inputs.
// The following class is responsible for running the model predictions and updating them in the SwiftUI Views
@Observable public class Recommender {
    
    // A list of artifacts that has been recommended by AI model
    var artifacts = [ArtifactRecommendation]()
    
    // Compiled data model that will be passed to the ML model for analyzation
    var compiledModel: [Int64: Double] = [:]
    
    // Initializer
    init(compiledModel: [Int64 : Double]) {
        self.compiledModel = compiledModel
        load()
    }
    
    // The number of similar items to be returned by the model output.
    let amountOfResults: Int64 = 6
    
    func load() {
        do{
            // Initialize the ArcyRecommender with configuration
            let recommender = try ArcyRecommender(configuration: MLModelConfiguration())
            
            // ArcyRecommenderInput - auto-generated class from the Core ML model.
            //User input is passed here, which is a dictionary of item-rating pairs.
            //
            // In the restrict argument, the items that should be excluded from the recommendation output are passed.
            let input = ArcyRecommenderInput(items: compiledModel, k: amountOfResults, restrict_: [], exclude: [])
            
            // The result returned from the recommender model consists of item recommendations and scores, which indicate how similar the recommended artifacts were to the artifacts liked by the user.
            let result = try recommender.prediction(input: input)
            var tempArtifacts = [ArtifactRecommendation]()
            
            for str in result.recommendations{
                let score = result.scores[str] ?? 0
                tempArtifacts.append(ArtifactRecommendation(ArtifactId: Int(str), isLiked: score))
            }
            self.artifacts = tempArtifacts
            
        } catch(let error){
            print("error is \(error.localizedDescription)")
        }
    }
    
}
